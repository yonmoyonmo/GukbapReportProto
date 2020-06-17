import 'package:flutter/material.dart';
import 'BuildList.dart';
import 'GukbapMap.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/메뉴판테두리투명.png'), fit: BoxFit.fill),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  width: 340,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/큰판때기투명.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Text(
                    "부산 국밥 보고서",
                    style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 29),
                  )),
              Container(
                width: 280,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/메뉴판띠투명.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return BuildList();
                      }));
                    },
                    child: Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/국밥보고서.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return GukbapMap();
                      }));
                    },
                    child: Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/국밥지도.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return BuildList();
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.all(15),
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/작은판때기투명.png'),
                              fit: BoxFit.fill),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "목 록",
                          style:
                              TextStyle(fontFamily: 'DungGeunMo', fontSize: 20),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                        return GukbapMap();
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.all(15),
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/작은판때기투명.png'),
                              fit: BoxFit.fill),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "지 도",
                          style:
                              TextStyle(fontFamily: 'DungGeunMo', fontSize: 20),
                        )),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/검색버튼투명.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Text(
                    "탐  색",
                    style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 20),
                  ))
            ]),
      ),
    ));
  }
}
