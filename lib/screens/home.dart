import 'package:MySpeedoMeter/services/location-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    var mySpeed = Provider.of<String>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: SingleChildScrollView(
                              child: Column(

            children: <Widget>[
                Text('Current Speed',style: TextStyle(fontSize: 50),),
                (mySpeed != null)
                    ? Text(
                        mySpeed,
                        style: TextStyle(
                          fontFamily: 'Digital1',
                          fontSize: 100,
                          color: Colors.greenAccent[400],
                        ),
                      )
                    : CircularProgressIndicator(),
                    Text('Km/h',style: TextStyle(fontSize: 30),),
                    SizedBox(height: 50,),
                    Text('From 10 to 30',style: TextStyle(fontSize: 40),),
                    Consumer<LocationService>(builder: (_,loca,__){
                     return Text(
                        (loca.accTime != null) ? loca.accTime.toString(): '--',
                        style: TextStyle(
                          fontFamily: 'Digital1',
                          fontSize: 80,
                          color: Colors.greenAccent[400],
                        ),
                      );
                    }),
                    Text('Seconds',style: TextStyle(fontSize: 30),),
                    SizedBox(height: 50,),
                    Text('From 30 to 10',style: TextStyle(fontSize: 40),),
                    Consumer<LocationService>(builder: (_,loca,__){
                     return Text(
                        (loca.decTime != null) ? loca.decTime.toString(): '--',
                        style: TextStyle(
                          fontFamily: 'Digital1',
                          fontSize: 80,
                          color: Colors.greenAccent[400],
                        ),
                      );
                    }),
                    Text('Seconds',style: TextStyle(fontSize: 30),),
            ],
          ),
              )),
        ),
      ),
    );
  }
}
