import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'HexColor.dart';
import 'DetailReport.dart';

class BuildList extends StatefulWidget {
  @override
  _BuildListState createState() => _BuildListState();
}

class _BuildListState extends State<BuildList> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: "https://onlypenstudio.com/graphqlapi/");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: InMemoryCache()),
    );
    return GraphQLProvider(
      child: CacheProvider(child: ReportList()),
      client: client,
    );
  }
}

class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
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
            body: _buildList(result),
          ),
        );
      },
    ));
  }

  Widget _buildList(QueryResult result) {
    List reports = result.data['allReports'];
    int length = reports.length;
    print(length);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: ListView.builder(
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            print(length);
            return _buildCards(result, index, context);
          },
        )));
  }
}

Widget _buildCards(QueryResult result, int index, BuildContext context) {
  String image = "https://onlypenstudio.com/media/" +
      result.data['allReports'][index]['Images'][0]['image'];
  String title = result.data['allReports'][index]['title'];
  String author = result.data['allReports'][index]['address'];
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/image/메뉴판테두리투명.png'), fit: BoxFit.fill),
    ),
    width: double.infinity,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return DetailReport(result, index);
        }));
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        elevation: 5.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: FadeInImage.memoryNetwork(
                  width: 300,
                  height: 225,
                  placeholder: kTransparentImage,
                  image: image,
                )),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'DungGeunMo',
                  ),
                )),
            Container(
                width: 350,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DungGeunMo',
                    fontSize: 15,
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}
