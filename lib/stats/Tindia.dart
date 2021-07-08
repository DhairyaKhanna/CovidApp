import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Ticases.dart';

class Tindia extends StatefulWidget {
  @override
  _TindiaState createState() => _TindiaState();
}

class _TindiaState extends State<Tindia> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";

  @override
  void initState() {
    super.initState();

    this.getJsonData();
  }

  Future<TI_cases> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body)['data']['summary'];

      return TI_cases.fromJson(convertDataJson);
    } else {
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Indian COVID-19 statistics'),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                      elevation: 10,
                      color: Colors.blue.withOpacity(0.5),
                      child: ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ),
                FutureBuilder<TI_cases>(
                    future: getJsonData(),
                    builder: (BuildContext context, SnapShot) {
                      if (SnapShot.hasData) {
                        final covid = SnapShot.data;
                        return Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                                color: Colors.lightBlueAccent.withOpacity(0.4),
                                elevation: 10,
                                child: ListTile(
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                      Text(
                                        "${covid.total} ",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${covid.deaths}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${covid.discharged}",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ]))),
                          )
                        ]);
                      } else if (SnapShot.hasError) {
                        return Text(SnapShot.error.toString());
                      }

                      return Center(child: CircularProgressIndicator());
                    }),
              ]),
        )));
  }
}
