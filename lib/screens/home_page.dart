import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruvu_app/screens/report_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _controller;
  final LatLng _initialLocation =
      const LatLng(-6.3833, 38.8667); // New York City coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Ruvu App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Report a problem'),
              onTap: () {
                // Navigate to the report screen
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => ReportPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('My complaints'),
              onTap: () {
                // Navigate to the settings screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My account'),
              onTap: () {
                // Navigate to the help screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.handyman),
              title: const Text('Rules'),
              onTap: () {
                // Perform logout action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () {
                // Perform logout action
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _initialLocation,
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => ReportPage()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15)
              ),
              child: const Text('Report Problem'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
