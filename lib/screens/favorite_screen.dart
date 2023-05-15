import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MyMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,),

      body: Center(
        child: Text(
          'Favorite Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
// class MyMapScreen extends StatefulWidget {
//   @override
//   _MyMapScreenState createState() => _MyMapScreenState();
// }
//
// class _MyMapScreenState extends State<MyMapScreen> {
//   // The initial location to show on the map
//   static const LatLng _center = const LatLng(45.521563, -122.677433);
//
//   // Create a controller for the Google Map
//   late GoogleMapController _controller;
//
//   // Create a set of markers to display on the map
//   final Set<Marker> _markers = {};
//
//   // Called when the Google Map has been created
//   void _onMapCreated(GoogleMapController controller) {
//     _controller = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Map Screen'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         markers: _markers,
//       ),
//     );
//   }
// }
