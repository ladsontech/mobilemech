import 'package:flutter/material.dart';
import 'package:mobileMech/src/auth/presentation/screens/login_screen.dart';
import 'package:mobileMech/src/auth/presentation/screens/registration_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/vehicle_owner_home_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/mechanic_home_screen.dart';
import 'package:mobileMech/src/user/presentation/screens/admin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mobileMech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/vehicle_owner_home': (context) => const VehicleOwnerHomeScreen(),
        '/mechanic_home': (context) => const MechanicHomeScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}
