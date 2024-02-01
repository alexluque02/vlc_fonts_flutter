import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parkings_map_vlc/model/fuentes_agua_response/fuentes_agua_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

Future<FuentesAguaResponse> fetchFonts() async {
  final response = await http.get(Uri.parse(
      'https://valencia.opendatasoft.com/api/explore/v2.1/catalog/datasets/fonts-daigua-publica-fuentes-de-agua-publica/records?limit=20'));

  if (response.statusCode == 200) {
    return FuentesAguaResponse.fromJson(response.body);
  } else {
    throw Exception('Failed to load Font');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(39.4697500, -0.3773900),
    zoom: 12,
  );

  late Future<FuentesAguaResponse> futureFont;

  @override
  void initState() {
    super.initState();
    futureFont = fetchFonts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<FuentesAguaResponse>(
        future: futureFont,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Build the GoogleMap only when data is available
            return GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.from(snapshot.data!.results!.map(
                (result) => Marker(
                  markerId: MarkerId(result.objectid.toString()),
                  position: LatLng(result.geoShape!.geometry!.coordinates![1],
                      result.geoShape!.geometry!.coordinates![0]),
                  //infoWindow: InfoWindow(title: result.name),
                ),
              )),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
