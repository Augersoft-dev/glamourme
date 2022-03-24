// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'place_detail.dart';

const kGoogleApiKey = "AIzaSyDP9OgsLY_HzPk9O3C9wAXmDaLgsOgPyRU";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);



class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  final MapPageScaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage!),
      );
    } else {
      expandedChild = buildPlacesList();
    }
    return Scaffold(
      body: Center(child: Text("MapPage"),),
    );

    // return Scaffold(
    //     key: MapPageScaffoldKey,
    //     appBar: AppBar(
    //       title: const Text("PlaceZ"),
    //       actions: <Widget>[
    //         isLoading
    //             ? IconButton(
    //                 icon: Icon(Icons.timer),
    //                 onPressed: () {},
    //               )
    //             : IconButton(
    //                 icon: Icon(Icons.refresh),
    //                 onPressed: () {
    //                   refresh();
    //                 },
    //               ),
    //         IconButton(
    //           icon: Icon(Icons.search),
    //           onPressed: () {
    //             _handlePressButton();
    //           },
    //         ),
    //       ],
    //     ),
    //     body: Column(
    //       children: <Widget>[
    //         Container(
    //           child: SizedBox(
    //               height: 200.0,
    //               child: GoogleMap(
    //                   onMapCreated: _onMapCreated,
    //                   mapToolbarEnabled: true,initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),)),
    //         ),
    //         Expanded(child: expandedChild)
    //       ],
    //     ));
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center!);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng?> getUserLocation() async {
    Map<String, double>? currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = (await location.getLocation()) as Map<String, double>;
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat!, lng!);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(lat: center.latitude, lng: center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
         
          final markerOptions = Marker(
              position:
                  LatLng(f.geometry!.location.lat, f.geometry!.location.lng),
              infoWindow: InfoWindow(
                title: "${f.name}",snippet: "${f.types.first}"), markerId: MarkerId(f.types.first.toString()));
          // mapController.addMarker(markerOptions);
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    MapPageScaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction? p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(lat:center.latitude, lng: center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p!.placeId.toString());
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId: placeId,)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}
