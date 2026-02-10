import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Users'),
          ),
          // Placeholder for user list
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Vehicle Owner 1'),
            subtitle: Text('owner1@example.com'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Vehicle Owner 2'),
            subtitle: Text('owner2@example.com'),
          ),
          Divider(),
          ListTile(
            title: Text('Mechanics'),
          ),
          // Placeholder for mechanic list
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Mechanic 1'),
            subtitle: Text('mechanic1@example.com'),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Mechanic 2'),
            subtitle: Text('mechanic2@example.com'),
            trailing: Icon(Icons.cancel, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
