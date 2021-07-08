import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

import '../HomeCard.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  Future onRefresh() async {
    Container(
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
                    itemCount: 27,
                    itemBuilder: (BuildContext context, index) => SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: GestureDetector(
                            onTap: () => showcard(
                                snapshot.data[index]['confirmedCasesIndian']
                                    .toString(),
                                snapshot.data[index]['confirmedCasesForeign']
                                    .toString(),
                                snapshot.data[index]['discharged'].toString(),
                                snapshot.data[index]['deaths'].toString()),
                            child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(
                                              "assets/images/cases.png"),
                                          height: 100,
                                          width: 100,
                                        ),
                                        Padding(padding: EdgeInsets.all(10)),
                                        Text(
                                          snapshot.data[index]['loc'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ]),
                                )))));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future showcard(String ind, inter, recover, death) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SingleChildScrollView(
                child: Container(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        "Indian Cases :$ind",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        "Foreigner Cases :$inter",
                        style:
                            TextStyle(fontSize: 16, color: Colors.indigoAccent),
                      ),
                      Text(
                        "Total Recoveries :$recover",
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      Text(
                        "Total Deaths :$death",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<List> datas;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Statewise Statistics'),
            backgroundColor: Color(0xFF152238)),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          child: Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: datas,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 10.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) =>
                                GestureDetector(
                                  onTap: () => showcard(
                                      snapshot.data[index]
                                              ['confirmedCasesIndian']
                                          .toString(),
                                      snapshot.data[index]
                                              ['confirmedCasesForeign']
                                          .toString(),
                                      snapshot.data[index]['discharged']
                                          .toString(),
                                      snapshot.data[index]['deaths']
                                          .toString()),
                                  child: HomeCard(
                                    heading: snapshot.data[index]['loc'],
                                    name:
                                        'Indian Cases:${snapshot.data[index]['confirmedCasesIndian'].toString()}',
                                    assetName: 'assets/images/cases.png',
                                  ),
                                )),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          onRefresh: () => onRefresh(),
        ));
  }
}
