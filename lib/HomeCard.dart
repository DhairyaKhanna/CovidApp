import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  HomeCard({this.name, this.heading, this.onPressed, this.assetName});

  final String name;
  final String heading;
  final Function onPressed;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Colors.lightBlueAccent.withOpacity(0.3)),
            ],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
            border: Border.all(width: 4, color: Colors.blueAccent)),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Text(
                heading ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
              ),
              Image(
                image: AssetImage(assetName),
                height: 90,
                width: 90,
              ),
              OutlineButton(
                borderSide: BorderSide(color: Colors.blueAccent),
                onPressed: () => onPressed,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ])));
  }
}
