import 'dart:async';
import 'HexColor.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'DetailReport.dart';

class GukbapMap extends StatefulWidget {
  @override
  _GukbapMapState createState() => _GukbapMapState();
}

class _GukbapMapState extends State<GukbapMap> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: "https://onlypenstudio.com/graphqlapi/");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: InMemoryCache()),
    );
    return GraphQLProvider(
      child: CacheProvider(child: Map01()),
      client: client,
    );
  }
}

class Map01 extends StatefulWidget {
  @override
  _Map01State createState() => _Map01State();
}

class _Map01State extends State<Map01> {
  final String listQuery = r"""
  
query{ 
    allReports{ 
        id 
        title 
        content
        author
        pubDate
      	openClose
      	phone
      	address
        youtubelink
        Images{
          image
        } 
        gukmools{ 
          yuksu
          yeomdo
          hexColor
          saewoo
          salt
          blackPepper 
          toRyeom 
          yangNyeomJang
          ddaroGukbap 
          NETgukbap 
        } 
        goguis{ 
          meatPart 
          texture 
          thickness 
          smell 
          dippingSource 
        } 
        kimchis{ 
          spicy 
          banchan 
        } 
        services{ 
          banchanTime 
          gukbaptime 
          kindness 
          banchanRefill 
          selfServing 
          gukmulRefill 
          dessert 
        } 
        weesaengs{ 
          floor 
          table 
          spoons 
          cups 
          kitchen 
          tissue 
          toilets 
        }
        latlngs{
          lat
          lng
        }
      } 
    }
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Query(
      options: QueryOptions(
        documentNode: gql(listQuery),
        //pollInterval: 500,
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/image/loading.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 300,
                child: Text(
                  "입 장 중",
                  style: TextStyle(fontFamily: "DungGeunMo", fontSize: 30),
                ),
              )
            ],
          );
        }

        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'DungGeunMo',
          ),
          title: "Busan Gukbap Report",
          home: Scaffold(
            body: BuildMapList(result),
          ),
        );
      },
    ));
  }
}

class BuildMapList extends StatefulWidget {
  QueryResult _result;
  BuildMapList(QueryResult result) {
    _result = result;
  }
  @override
  _BuildMapListState createState() => _BuildMapListState(_result);
}

class _BuildMapListState extends State<BuildMapList> {
  QueryResult _result;
  _BuildMapListState(QueryResult result) {
    _result = result;
  }
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    CameraPosition _startPosition = CameraPosition(
      target: LatLng(35.164413, 129.060300),
      zoom: 12,
    );

    int leng = _result.data['allReports'].length;
    List<Marker> allMarkers = [];
    int index = 0;
    for (int i = 0; i < leng; i++) {
      double lat = _result.data['allReports'][i]['latlngs'][0]['lat'];
      double lng = _result.data['allReports'][i]['latlngs'][0]['lng'];
      allMarkers.add(Marker(
        markerId: MarkerId(_result.data['allReports'][i]['id']),
        draggable: false,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: _result.data['allReports'][i]['title'],
        ),
        icon: BitmapDescriptor.fromAsset("assets/my_icon.png"),
        onTap: () {
          index = i;
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return DetailReport(_result, index);
          }));
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "국밥 지도",
          style: TextStyle(
            fontFamily: 'DungGeunMo',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: HexColor("#735740"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _startPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(allMarkers),
      ),
    );
  }
}
