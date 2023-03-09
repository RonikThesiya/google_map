import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => MyHomePage(),
        'map':(context) => MapScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List placeName = ['Mota Varachha', 'Kolkata', 'Mumbai', 'Banglore' , 'Live Location',];

  double lon =0.0 , lat=0.0;


  void getPosition() async {

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
       lat = position.latitude;
       lon = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pl = [
      LatLng(21.2408, 72.8806),
      LatLng(22.5726, 88.3639),
      LatLng(19.0760, 72.8777),
      LatLng(12.9716, 77.5946),
    ];
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 250,left: 100,right: 100),
                  child: ListView.builder(
                      itemCount: placeName.length,
                      itemBuilder: (context, index) {
                       return ElevatedButton(
                          onPressed: () async {
                            if (await Permission.location.isDenied) {
                              Permission.location.request();
                            } else if (await Permission.location.isGranted) {

                                Position position = await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high);

                                pl.add(LatLng(position.latitude,position.longitude));
                                (LatLng(position.latitude,position.longitude));

                               Navigator.pushNamed(context, 'map',arguments: pl[index]);
                            }
                          },
                          child: Text("${placeName[index]}"),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
