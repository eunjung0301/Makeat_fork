import 'package:flutter/material.dart';

import 'package:toonflix/charts/pid_chart.dart';

class ChartPage extends StatelessWidget {
  List<double> points = [50, 90, 1003, 500, 150, 120, 200, 80];

  List<String> labels = [
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint(
                  size: const Size(60, 60),
                  painter: PieChart(
                      percentage: 55,
                      textScaleFactor: 1.5,
                      textColor: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
