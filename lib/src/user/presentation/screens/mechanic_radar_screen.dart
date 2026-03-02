import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MechanicRadarScreen extends StatefulWidget {
  const MechanicRadarScreen({super.key});

  @override
  State<MechanicRadarScreen> createState() => _MechanicRadarScreenState();
}

class _MechanicRadarScreenState extends State<MechanicRadarScreen> {
  static const LatLng _center = LatLng(0.3476, 32.5825); // Kampala
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  int? _selectedMechanicIndex;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> _mechanics = [
    {
      'name': 'FixIt Pro',
      'rating': 4.8,
      'specialty': 'Engine Specialist',
      'image': 'assets/images/mech1.jpg'
    },
    {
      'name': 'Kampala Auto',
      'rating': 4.5,
      'specialty': 'General Repair',
      'image': 'assets/images/mech2.jpg'
    },
    {
      'name': 'Quick Fix Garage',
      'rating': 4.2,
      'specialty': 'Tire & Brake',
      'image': 'assets/images/mech3.jpg'
    },
    {
      'name': 'Elite Mechanics',
      'rating': 4.9,
      'specialty': 'Luxury Cars',
      'image': 'assets/images/mech4.jpg'
    },
    {
      'name': 'MotoCare',
      'rating': 4.6,
      'specialty': 'Oil & Lube',
      'image': 'assets/images/mech5.jpg'
    },
  ];

  @override
  void initState() {
    super.initState();
    _generateMarkers();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _generateMarkers() {
    _markers.clear();
    // User Marker
    _markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: _center,
        infoWindow: const InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    const double radius = 0.005; // Approx 500m radius
    const double angleStep = (2 * pi) / 5;

    for (int i = 0; i < _mechanics.length; i++) {
      final double angle = i * angleStep;
      final double lat = _center.latitude + radius * sin(angle);
      final double lng = _center.longitude + radius * cos(angle);

      _mechanics[i]['lat'] = lat;
      _mechanics[i]['lng'] = lng;
      _mechanics[i]['distance'] = '${(0.5 + i * 0.2).toStringAsFixed(1)} km';

      _markers.add(
        Marker(
          markerId: MarkerId('mechanic_$i'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              _selectedMechanicIndex == i
                  ? BitmapDescriptor.hueRed
                  : BitmapDescriptor.hueOrange),
          onTap: () => _onMarkerTapped(i),
        ),
      );
    }
    setState(() {});
  }

  void _onMarkerTapped(int index) {
    setState(() {
      _selectedMechanicIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    _generateMarkers();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedMechanicIndex = index;
    });
    final mech = _mechanics[index];
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(LatLng(mech['lat'], mech['lng'])),
    );
    _generateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
          child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.orange),
              onPressed: () => Navigator.pushNamed(context, '/account'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Google Map (Full Screen)
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 15,
            ),
            markers: _markers,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _mapController = controller,
            padding: const EdgeInsets.only(bottom: 240, top: 120),
          ),

          // 2. Top UI: Search Bar & Filters
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  // Search Bar removed for now as it's more relevant on Dashboard,
                  // or we keep it as "Search Location". Keeping it simple for Radar.
                  // Actually, let's keep the filter chips as they are useful for "Body" vs "Engine".
                ],
              ),
            ),
          ),

          // 3. Horizontal Mechanic List
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            height: 170,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _mechanics.length,
              itemBuilder: (context, index) {
                final mech = _mechanics[index];
                final isSelected = _selectedMechanicIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 12), // Adjusted margin
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // Rounder
                    border: isSelected
                        ? Border.all(color: Colors.orange, width: 2)
                        : Border.all(color: Colors.transparent, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05), // Lighter shadow
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _onMarkerTapped(index),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'mech_avatar_$index',
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(mech['name'][0],
                                        style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange))),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mech['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    mech['specialty'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.orange.shade50,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                size: 12,
                                                color: Colors.orange[700]),
                                            const SizedBox(width: 2),
                                            Text("${mech['rating']}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange[800])),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        mech['distance'] ?? '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
