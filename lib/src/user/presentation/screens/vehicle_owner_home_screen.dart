import 'package:flutter/material.dart';

class VehicleOwnerHomeScreen extends StatelessWidget {
  const VehicleOwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Mechanic'),
      ),
      body: Stack(
        children: [
          // Placeholder for the map
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Map Placeholder',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement request mechanic logic
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Request a Mechanic'),
            ),
          ),
        ],
      ),
    );
  }
}
