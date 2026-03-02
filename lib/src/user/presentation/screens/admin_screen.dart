import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin Panel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Text(_getTitle(),
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        actions: const [],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 4) {
            Navigator.pushNamed(context, '/account');
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        selectedItemColor: Colors.orange,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Mechanics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Overview';
      case 1:
        return 'User Management';
      case 2:
        return 'Mechanic Management';
      case 3:
        return 'Orders & Revenue';
      default:
        return 'Overview';
    }
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardView();
      case 1:
        return _buildUsersView();
      case 2:
        return _buildMechanicsView();
      case 3:
        return _buildOrdersView();
      default:
        return _buildDashboardView();
    }
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: _buildMetricCard(
                      'Total\nUsers', '1,245', Icons.people, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildMetricCard(
                      'Active\nMechanics', '42', Icons.build, Colors.orange)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildMetricCard('Pending\nVerifications', '8',
                      Icons.verified_user, Colors.purple)),
            ],
          ),
          const SizedBox(height: 24),
          const Text('System Health',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildActivityItem('Server Status', 'Operational', Colors.green),
          _buildActivityItem('Database', 'Healthy', Colors.green),
          _buildActivityItem('Last Backup', '2 hours ago', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildUsersView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Manage Users',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildUserListTile('Alice Johnson', 'alice@example.com', 'Active'),
        _buildUserListTile('Bob Smith', 'bob@example.com', 'Active'),
        _buildUserListTile('Charlie Brown', 'charlie@example.com', 'Suspended',
            isSuspended: true),
      ],
    );
  }

  Widget _buildMechanicsView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Mechanic Requests',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildMechanicListTile(
            'Mike The Mechanic', 'mike@garage.com', 'Pending',
            isPending: true),
        const SizedBox(height: 24),
        const Text('Verified Mechanics',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildMechanicListTile('FixIt Fast', 'contact@fixit.com', 'Verified'),
        _buildMechanicListTile('AutoCare Pro', 'info@autocare.com', 'Verified'),
      ],
    );
  }

  Widget _buildOrdersView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Pending Requests Section
        const Text('Pending Requests',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildPendingRequestTile('#REQ-2024-001', 'Alice Johnson',
            'Vehicle Breakdown - 5km away', 'Unassigned'),
        _buildPendingRequestTile(
            '#REQ-2024-005', 'David Kim', 'Flat Tire - 2km away', 'Unassigned'),

        const SizedBox(height: 24),

        // Recent Transactions Section
        const Text('Recent Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildOrderTile('#ORD-2024-001', 'Alice Johnson', 'Mike The Mechanic',
            '\$45.00', 'Completed', Colors.green),
        _buildOrderTile('#ORD-2024-002', 'Bob Smith', 'FixIt Fast', '\$120.00',
            'In Progress', Colors.orange),
        _buildOrderTile('#ORD-2024-003', 'John Doe', 'AutoCare Pro', '\$30.00',
            'Cancelled', Colors.red),
      ],
    );
  }

  Widget _buildPendingRequestTile(
      String reqId, String user, String issue, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.red.withOpacity(0.05), blurRadius: 10)
        ],
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(reqId,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Action Required',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(issue,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text('User: $user',
                  style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showMechanicSelectionSheet(context, reqId),
              icon: const Icon(Icons.person_add_alt_1, size: 16),
              label: const Text('Assign Mechanic'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMechanicSelectionSheet(BuildContext context, String reqId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Assign Mechanic for $reqId',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Select a mechanic to handle this request',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildMechanicSelectionItem(
                        context, 'Mike The Mechanic', '4.8', '0.5 km'),
                    _buildMechanicSelectionItem(
                        context, 'FixIt Fast', '4.5', '1.2 km'),
                    _buildMechanicSelectionItem(
                        context, 'AutoCare Pro', '4.2', '3.0 km'),
                    _buildMechanicSelectionItem(
                        context, 'Kampala Auto', '4.9', '0.8 km'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMechanicSelectionItem(
      BuildContext context, String name, String rating, String distance) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange.withOpacity(0.1),
        child: Text(name[0], style: const TextStyle(color: Colors.orange)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('⭐ $rating • $distance away'),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Assigned $name to request!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          minimumSize: const Size(80, 30),
        ),
        child: const Text('Assign'),
      ),
    );
  }

  Widget _buildOrderTile(String orderId, String user, String mechanic,
      String amount, String status, Color statusColor) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderId,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(amount,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green)),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text('User: $user',
                  style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.build_circle_outlined,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Mech: $mechanic',
                  style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String status, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _buildUserListTile(String name, String email, String status,
      {bool isSuspended = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(name[0], style: const TextStyle(color: Colors.black)),
        ),
        title: Text(name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(email, style: const TextStyle(fontSize: 12)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSuspended
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status,
              style: TextStyle(
                  fontSize: 10,
                  color: isSuspended ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildMechanicListTile(String name, String email, String status,
      {bool isPending = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.orange[100],
          child: const Icon(Icons.build, size: 16, color: Colors.orange),
        ),
        title: Text(name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(email, style: const TextStyle(fontSize: 12)),
        trailing: isPending
            ? ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(60, 30),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Verify',
                    style: TextStyle(fontSize: 11, color: Colors.white)))
            : const Icon(Icons.check_circle, color: Colors.green, size: 20),
      ),
    );
  }
}
