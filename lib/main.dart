import 'package:MySpeedoMeter/screens/home.dart';
import 'package:MySpeedoMeter/services/location-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamProvider<String>(
        create: (BuildContext context) => LocationService().speedStream,
        child: Home(),
      ),
    );
  }
}
