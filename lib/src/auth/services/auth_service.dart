import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get the currently signed-in user.
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password.
  /// Returns the user's role from Firestore.
  Future<String> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Fetch user role from Firestore
      final userDoc =
          await _firestore.collection('users').doc(credential.user!.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        return userDoc.data()!['role'] as String? ?? 'vehicle_owner';
      }
      return 'vehicle_owner';
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Register a new user with email, password, name, and role.
  /// After registration, the user is signed out so they can log in manually.
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update display name
      await credential.user!.updateDisplayName(name);

      // Store user data in Firestore
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Sign out after registration so user goes back to login screen
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Send a password reset email.
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Get the role of the current user from Firestore.
  Future<String?> getCurrentUserRole() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        return userDoc.data()!['role'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get the current user's display name.
  String? get currentUserName => _auth.currentUser?.displayName;

  /// Get the current user's email.
  String? get currentUserEmail => _auth.currentUser?.email;

  /// Convert Firebase auth exceptions to user-friendly messages.
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}
