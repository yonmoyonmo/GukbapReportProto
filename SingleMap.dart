import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleMap extends StatefulWidget {
  QueryResult _result;
  int _index;

  SingleMap(QueryResult result, int index) {
    _result = result;
    _index = index;
  }
  @override
  _SingleMapState createState() => _SingleMapState(_result, _index);
}

class _SingleMapState extends State<SingleMap> {
  QueryResult _result;
  int _index;

  _SingleMapState(QueryResult result, int index) {
    _result = result;
    _index = index;
  }

  List<Marker> aMark = [];
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    double lat = _result.data['allReports'][_index]['latlngs'][0]['lat'];
    double lng = _result.data['allReports'][_index]['latlngs'][0]['lng'];
    String id = _result.data['allReports'][_index]['id'];
    String title = _result.data['allReports'][_index]['title'];
    CameraPosition _startPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 17,
    );
    aMark.add(Marker(
      markerId: MarkerId(id),
      draggable: false,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: title,
      ),
      icon: BitmapDescriptor.fromAsset("assets/my_icon.png"),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _startPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(aMark),
      ),
    );
  }
}
