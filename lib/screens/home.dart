import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged in'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: Column(
            children: [
              ListTile(
                  title: const Text('Welcome!'),
                  subtitle: Text(FirebaseAuth.instance.currentUser!.email!)),
            ],
          ),
        ),
      ),
      body: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 11.0,
  );

  CameraPosition _position = _kInitialPosition;

  // late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: _position);
  }
}
