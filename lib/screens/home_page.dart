import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ruvu_app/screens/profile.dart';
import 'package:ruvu_app/screens/report_page.dart';
import 'package:ruvu_app/screens/rulesPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _controller;
  final LatLng _initialLocation =
      const LatLng(-6.3833, 38.8667); // Ruvu coordinates

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
                image: DecorationImage(
                    image: AssetImage('assets/ruvu_river.jpg'),
                fit: BoxFit.fitWidth
                )
              ),
              child: Center(
                child: Text(
                  'Ruvu reporting App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
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
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => const ProfilePage
                  (email: 'engineerjarvis@gmail.com',
                    username: 'Jarvis Engineer',
                    mobile: '+255 785 545 384',)));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.handyman),
              title: const Text('Rules'),
              onTap: () {
                // Perform logout action
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => RulesPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () async {
                // Perform logout action
                await FirebaseAuth.instance.signOut();
               //
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: GoogleMap(
        compassEnabled: true,
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
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
