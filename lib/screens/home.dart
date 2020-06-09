import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mySpeed = Provider.of<String>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
            ],
          )),
        ),
      ),
    );
  }
}
