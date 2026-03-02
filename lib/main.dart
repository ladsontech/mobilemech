import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileMech/src/auth/presentation/screens/login_screen.dart';
import 'package:mobileMech/src/auth/presentation/screens/registration_screen.dart';
import 'package:mobileMech/src/auth/services/auth_service.dart';
import 'package:mobileMech/src/user/presentation/screens/vehicle_owner_home_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/mechanic_home_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/admin_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/simple_navigation_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MDER',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      home: const AuthGate(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/vehicle_owner_home': (context) => const VehicleOwnerHomeScreen(),
        '/mechanic_home': (context) => const MechanicHomeScreen(),
        '/admin': (context) => const AdminScreen(),
        '/account': (context) => const AccountScreen(),
        '/role_selection': (context) => const RoleSelectionScreen(),
      },
    );
  }
}

/// Checks Firebase auth state and routes the user accordingly.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading indicator while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is signed in, route based on their role
        if (snapshot.hasData) {
          return FutureBuilder<String?>(
            future: AuthService().getCurrentUserRole(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final role = roleSnapshot.data ?? 'vehicle_owner';
              switch (role) {
                case 'mechanic':
                  return const MechanicHomeScreen();
                case 'admin':
                  return const AdminScreen();
                case 'vehicle_owner':
                default:
                  return const VehicleOwnerHomeScreen();
              }
            },
          );
        }

        // Not signed in — show login
        return const LoginScreen();
      },
    );
  }
}
