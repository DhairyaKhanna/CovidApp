import 'package:covid_app/model/Tcases.dart';
import '../HomeCard.dart';
import '../appbar.dart';
import 'Hospital.dart';
import 'Tindia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'India.dart';
import 'World.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Hstate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://corona.lmao.ninja/all";

  navigateToWHO(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Text('Link is not Working $url');
    }
  }

  navigateToIndia() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Tindia()));
  }

  navigateToIndiaMap() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => India()));
  }

  navigateToWorld() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => World()));
  }

  navigateToHospital() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hospital()));
  }

  navigateToHstate() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hstate()));
  }

  @override
  void initState() {
    super.initState();

    this.getJsonData();
  }

  Future<TCases> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);

      return TCases.fromJson(convertDataJson);
    } else {
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Stay',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Card(
                      child: Text('Home',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Worldwide statistics',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    OutlineButton(
                      color: Colors.blueAccent,
                      borderSide: BorderSide(color: Colors.blue),
                      onPressed: () => navigateToIndia(),
                      child: Text('India statistics',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  ]),
              FutureBuilder<TCases>(
                  future: getJsonData(),
                  builder: (BuildContext context, SnapShot) {
                    if (SnapShot.hasData) {
                      final covid = SnapShot.data;
                      return Column(children: <Widget>[
                        Card(
                            color: Color(0xFF292929),
                            child: ListTile(
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                  Text(
                                    "${covid.cases} ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${covid.deaths}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("${covid.recovered}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold)),
                                ]))),
                        Card(
                            color: Color(0xFF292929),
                            child: ListTile(
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                  Text(
                                    "Total Cases ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Deaths",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Recoveries",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ]))),
                      ]);
                    } else if (SnapShot.hasError) {
                      return Text(SnapShot.error.toString());
                    }

                    return Center(child: CircularProgressIndicator());
                  }),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      itemCount: homePageWidgets.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => screens[index]));
                            },
                            child: HomeCard(
                                name: homePageWidgets[index][0],
                                assetName: homePageWidgets[index][1],
                                onPressed: () {}),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                    elevation: 20,
                    child: Container(
                        color: Colors.white,
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              Image(
                                image: AssetImage("assets/images/myth.png"),
                                height: 100,
                                width: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlineButton(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                  onPressed: () => navigateToWHO(
                                      "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses"),
                                  child: Text(
                                    "Myth Busters by WHO",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ])))),
              ),
            ],
          )),
        )));
  }

  List homePageWidgets = [
    ['Indian StateWise Statistics', 'assets/images/india.png'],
    ['CountryWise Statistics', 'assets/images/world.png'],
    ['Indian Hospital Statistics', 'assets/images/hospital.png'],
    ['Indian Hospital StateWise Statistics', 'assets/images/hs.png'],
  ];
  List screens = [India(), World(), Hospital(), Hstate()];
}
