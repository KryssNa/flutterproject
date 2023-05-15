import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/title.dart';
import 'firestore/add_address.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(27.72232896074384, 85.31875074239964),
                    zoom: 15),
                markers: {
                  Marker(
                    markerId: MarkerId('nyc'),
                    position: LatLng(27.72232896074384, 85.31875074239964),
                    infoWindow: InfoWindow(
                      title: 'Your Current Location',
                    ),
                  ),
                },
              )),
          ElevatedButton(
              onPressed: () {
                const Icon(Icons.maps_home_work);
                Navigator.of(context).push(
                  //Replacement
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddAddressScreen(),
                  ),
                );
              },
              child: CustomText(text: "<- map location ", size: 18)),
        ],
      ),
    );
  }
}
