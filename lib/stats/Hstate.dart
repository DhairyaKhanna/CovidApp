import 'package:covid_app/HomeCard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class Hstate extends StatefulWidget {
  @override
  _HstateState createState() => _HstateState();
}

class _HstateState extends State<Hstate> {
  final String url = "https://api.rootnet.in/covid19-in/stats/hospitals";

  Future<List> datas;

  Future<List> getHData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }

  @override
  void initState() {
    super.initState();

    datas = this.getHData();
  }

  Future showcard(String ind, inter, recover, death, hospital, beds) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    "Total Hospital :$ind",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    "Beds :$inter",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    "Total Hospitals in urban Area :$recover",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    "Beds :$death",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    "Total Hospitals in rural area:$hospital",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    "Beds :$beds",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Statewise Statistics'),
            backgroundColor: Color(0xFF152238)),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
              future: datas,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) => SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: GestureDetector(
                            onTap: () => showcard(
                                snapshot.data[index]['totalHospitals']
                                    .toString(),
                                snapshot.data[index]['totalBeds'].toString(),
                                snapshot.data[index]['urbanHospitals']
                                    .toString(),
                                snapshot.data[index]['urbanBeds'].toString(),
                                snapshot.data[index]['ruralHospitals']
                                    .toString(),
                                snapshot.data[index]['ruralBeds'].toString()),
                            child: HomeCard(
                              assetName: 'assets/images/heart.png',
                              name: snapshot.data[index]['state'],
                              heading:
                                  'Total beds: ${snapshot.data[index]['totalBeds'].toString()}',
                            ),
                          )));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }
}
