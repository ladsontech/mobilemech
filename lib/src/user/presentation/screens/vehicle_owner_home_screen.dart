import 'package:flutter/material.dart';
import 'mechanic_radar_screen.dart';

class VehicleOwnerHomeScreen extends StatefulWidget {
  const VehicleOwnerHomeScreen({super.key});

  @override
  State<VehicleOwnerHomeScreen> createState() => _VehicleOwnerHomeScreenState();
}

class _VehicleOwnerHomeScreenState extends State<VehicleOwnerHomeScreen> {
  // Dummy data for Quick Order logic
  final List<Map<String, dynamic>> _mechanics = [
    {
      'name': 'FixIt Pro',
      'rating': 4.8,
      'specialty': 'Engine Specialist',
      'distance': '0.5 km'
    },
    {
      'name': 'Kampala Auto',
      'rating': 4.5,
      'specialty': 'General Repair',
      'distance': '1.2 km'
    },
  ];

  void _requestQuickOrder() {
    final nearestMech = _mechanics.first;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recommending the best mechanic nearby:'),
            const SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: Text(nearestMech['name'][0],
                    style: const TextStyle(color: Colors.orange)),
              ),
              title: Text(nearestMech['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${nearestMech['specialty']} • ${nearestMech['distance']} away'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Order sent to ${nearestMech['name']}!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Confirm Order',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning,',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text('Eddy', // User Name Updated
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
        actions: const [], // Removed Account Button as requested
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Services Section
              const Text('Services',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold)), // Slightly smaller header
              const SizedBox(height: 12),

              // Auto-fit Row (Expanded)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align top
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      'Order\nMechanic', // Renamed
                      Icons.car_repair, // Changed Icon
                      Colors.redAccent,
                      _requestQuickOrder,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      'Mechanics\nNear Me',
                      Icons.map,
                      Colors.orange,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MechanicRadarScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      'Spare\nParts', // Renamed
                      Icons.shopping_cart,
                      Colors.blue,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Spare Parts coming soon!')));
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Recent Activities Section
              const Text('Recent Activities',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildActivityItem(
                  'Engine Checkup', 'FixIt Pro', 'Completed', Colors.green),
              _buildActivityItem('Tire Replacement', 'Quick Fix Garage',
                  'Pending', Colors.orange),
              _buildActivityItem(
                  'Oil Change', 'Kampala Auto', 'Completed', Colors.green),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default to Home for now
        onTap: (index) {
          if (index == 3) {
            // Navigate to Account Screen if "Account" (index 3) is tapped
            Navigator.pushNamed(context, '/account');
          }
          // Placeholder for other tabs
        },
        selectedItemColor: Colors.orange,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Inbox'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account'), // Changed Settings to Account
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon,
      Color accentColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110, // Slightly simpler height
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: accentColor,
                  size: 24), // Slightly larger icon again for balance
            ),
            const SizedBox(height: 8), // Add spacing
            Text(
              title,
              textAlign: TextAlign.center, // Center text
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String subtitle, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Icon(Icons.build_circle_outlined, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status,
                style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
