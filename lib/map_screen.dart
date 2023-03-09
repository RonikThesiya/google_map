import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};



  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    dynamic Location = ModalRoute
        .of(context)!
        .settings
        .arguments;
    final marker = Marker(

      markerId: MarkerId('place_name'),
      position: Location,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic Location = ModalRoute
        .of(context)!
        .settings
        .arguments;


    return Scaffold(
      body: GoogleMap(
        trafficEnabled: true,
        buildingsEnabled: true,
        onTap: (value){
        Location = value;
        print(value);
        },
      mapType: MapType.normal,
      markers: markers.values.toSet(),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: Location,
        zoom: 14.0,
      ),
      ),);
  }
}
