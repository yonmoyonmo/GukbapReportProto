import 'utilities/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter/rendering.dart';
import 'SingleMap.dart';
import 'HexColor.dart';

class DetailReport extends StatefulWidget {
  QueryResult _result;
  int _index;

  DetailReport(QueryResult result, int index) {
    _result = result;
    _index = index;
  }
  @override
  _DetailReportState createState() => _DetailReportState(_result, _index);
}

class _DetailReportState extends State<DetailReport> {
  QueryResult _result;
  int _index;

  _DetailReportState(QueryResult result, int index) {
    _result = result;
    _index = index;
  }

  @override
  Widget build(BuildContext context) {
    String title = _result.data['allReports'][_index]['title'];
    String author = _result.data['allReports'][_index]['author'];
    String content = _result.data['allReports'][_index]['content'];
    String yLink = _result.data['allReports'][_index]['youtubelink'];
    String openClose = _result.data['allReports'][_index]['openClose'];
    String phone = _result.data['allReports'][_index]['phone'];
    String address = _result.data['allReports'][_index]['address'];

    TextStyle biggerFont = TextStyle(
        fontFamily: 'DungGeunMo', fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle basic =
        TextStyle(fontFamily: 'DungGeunMo', fontSize: 17, height: 2);
    TextStyle smallerFont =
        TextStyle(fontFamily: 'DungGeunMo', fontSize: 14, height: 1);

    List images = _result.data['allReports'][_index]['Images'];
    String endPoint = "https://onlypenstudio.com/media/";

    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            bottom: true,
            top: true,
            child: Column(
              children: <Widget>[
                Container(
                    height: deviceHeight / 4,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 266,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: endPoint + images[0]['image'],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 266,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: endPoint + images[1]['image'],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 266,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: endPoint + images[2]['image'],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 266,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: endPoint + images[3]['image'],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 266,
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: endPoint + images[4]['image'],
                          ),
                        ),
                      ],
                    )),
                Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(title, style: biggerFont),
                        Text(author, style: smallerFont),
                      ],
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text("주소 : " + address, style: smallerFont),
                      Text("영업시간 : " + openClose, style: smallerFont),
                      Text("연락처 : " + phone, style: smallerFont),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Tooltip(
                            message: '국물정보',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/icons/국물.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: InkWell(onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return detailGukInfo(_result
                                      .data['allReports'][_index]['gukmools']);
                                }));
                              }),
                            ),
                          ),
                          Tooltip(
                            message: '고기정보',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/icons/고기.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: InkWell(onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return detailGoInfo(_result.data['allReports']
                                      [_index]['goguis']);
                                }));
                              }),
                            ),
                          ),
                          Tooltip(
                            message: '김치정보',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/icons/김치.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: InkWell(onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return detailKimInfo(_result
                                      .data['allReports'][_index]['kimchis']);
                                }));
                              }),
                            ),
                          ),
                          Tooltip(
                            message: '서빙정보',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/icons/서비스.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: InkWell(onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return detailSerInfo(_result
                                      .data['allReports'][_index]['services']);
                                }));
                              }),
                            ),
                          ),
                          Tooltip(
                            message: '위생정보',
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/icons/위생.png'),
                                    fit: BoxFit.fill),
                              ),
                              child: InkWell(onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return detailWeInfo(_result.data['allReports']
                                      [_index]['weesaengs']);
                                }));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/메뉴판테두리투명.png'),
                              fit: BoxFit.fill),
                        ),
                        height: deviceHeight / 2.5,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Text(
                              content,
                              style: basic,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Tooltip(
                                  message: '지도',
                                  child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/icons/지도.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute<void>(builder:
                                                  (BuildContext context) {
                                            return SingleMap(_result, _index);
                                          }));
                                        },
                                      )),
                                ),
                                Tooltip(
                                  message: '유튜브',
                                  child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/icons/유튜브.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: InkWell(
                                        onTap: () => playYoutube(yLink),
                                      )),
                                ),
                                Tooltip(
                                  message: '전화걸기',
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/icons/전화.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Tooltip(
                                  message: '뒤로가기',
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/icons/뒤로가기.png'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ],
                )),
              ],
            )));
  }

  void playYoutube(String url) {
    FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: API_KEY, videoUrl: url, autoPlay: false, fullScreen: false);
  }

  Widget detailGukInfo(List info) {
    String yuksu = info[0]['yuksu'];
    String yeom = info[0]['yeomdo'];
    String hexColor = info[0]['hexColor'];
    String saewoo = info[0]['saewoo'];
    String salt = info[0]['salt'];
    String blackPepper = info[0]['blackPepper'];
    String toRyeom = info[0]['toRyeom'];
    String yang = info[0]['yangNyeomJang'];
    String ddaro = info[0]['ddaroGukbap'];
    String netGuck = info[0]['NETgukbap'];
    return Scaffold(
      appBar: AppBar(title: Text("국 물 정 보")),
      body: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              color: HexColor(hexColor),
              child: Text("국밥 색", style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("육수 : " + yuksu, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("염도 : " + yeom, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("새우젓 : " + saewoo, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("소금 : " + salt, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child:
                  Text("후추 : " + blackPepper, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("토렴 : " + toRyeom, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("양념장(다대기) : " + yang, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Text("따로국밥 : " + ddaro, style: TextStyle(fontSize: 20)),
            ),
            Container(
              child:
                  Text("네츄럴 국밥 : " + netGuck, style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailGoInfo(List info) {
    String meatPart = info[0]['meatPart'];
    String texture = info[0]['texture'];
    String thickness = info[0]['thickness'];
    String smell = info[0]['smell'];
    String dippingSource = info[0]['dippingSource'];

    return Scaffold(
      appBar: AppBar(title: Text("고 기 정 보")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("고기 부위 : " + meatPart, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("질감 : " + texture, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("두께 : " + thickness, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("잡내 : " + smell, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("고기 찍먹 소스 : " + dippingSource,
                style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget detailKimInfo(List info) {
    String spicy = info[0]['spicy'];
    String banchan = info[0]['banchan'];

    return Scaffold(
      appBar: AppBar(title: Text("김 치 정 보")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("매운 정도 : " + spicy, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("밑반찬 : " + banchan, style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget detailSerInfo(List info) {
    String banchanTime = info[0]["banchanTime"];
    String gukbaptime = info[0]['gukbaptime'];
    String kindess = info[0]['kindness'];
    String banchanRefill = info[0]['banchanRefill'];
    String selfServing = info[0]['selfServing'];
    String gukmulRefill = info[0]['gukmulRefill'];
    String dessert = info[0]['dessert'];

    return Scaffold(
      appBar: AppBar(title: Text("서 빙 정 보")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("밑반찬 서빙 된 시간 : " + banchanTime,
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("국밥 서빙 된 시간 : " + gukbaptime,
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("친절함 : " + kindess, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("반찬 리필 : " + banchanRefill,
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("밑반찬 셀프 서빙 : " + selfServing,
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("국밥 국물 리필 : " + gukmulRefill,
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("후식(커피자판기, 박하사탕 등) : " + dessert,
                style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget detailWeInfo(List info) {
    String floor = info[0]['floor'];
    String table = info[0]['table'];
    String spoons = info[0]['spoons'];
    String cups = info[0]['cups'];
    String kitchen = info[0]['kitchen'];
    String tissue = info[0]['tissue'];
    String toilets = info[0]['toilets'];

    return Scaffold(
      appBar: AppBar(title: Text("위 생 정 보")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("바닥 : " + floor, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("테이블 : " + table, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("수저 : " + spoons, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("물컵 : " + cups, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("주방 : " + kitchen, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("물티슈 : " + tissue, style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text("화장실 : " + toilets, style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
