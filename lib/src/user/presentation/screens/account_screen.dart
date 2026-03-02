import 'package:flutter/material.dart';
import 'package:mobileMech/src/auth/services/auth_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final userName = authService.currentUserName ?? 'User';
    final userEmail = authService.currentUserEmail ?? 'No email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(userName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(userEmail, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Settings Section
          const Text('Settings',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_outlined,
                      color: Colors.orange),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange.withOpacity(0.3),
                  ),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined,
                      color: Colors.orange),
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: false,
                    onChanged: (val) {},
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange.withOpacity(0.3),
                  ),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                const ListTile(
                  leading: Icon(Icons.language_outlined, color: Colors.orange),
                  title: Text('Language'),
                  trailing: Text('English',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Actions
          Card(
            elevation: 2,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined, color: Colors.blue),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  onTap: () async {
                    await authService.signOut();
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
