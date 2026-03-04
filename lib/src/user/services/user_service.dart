import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobileMech/src/user/models/user_profile.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserProfile(UserProfile userProfile) async {
    await _usersCollection.doc(userProfile.uid).set(userProfile.toJson());
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final snapshot = await _usersCollection.doc(uid).get();
    if (snapshot.exists) {
      return UserProfile.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    await _usersCollection.doc(userProfile.uid).update(userProfile.toJson());
  }
}
