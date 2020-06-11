import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationService with ChangeNotifier {
  Location _location = Location();
  // var mySpeed = '';
  int accTime;
  int decTime;
  bool accelerate = true;
  var times = <double>[];

  StreamController<String> _speedController =
      StreamController<String>.broadcast();

  Stream<String> get speedStream => _speedController.stream;

  LocationService() {
    _location.changeSettings(accuracy: LocationAccuracy.navigation);
    _location.requestPermission().then((PermissionStatus permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        _location.onLocationChanged.listen((LocationData locationData) {
          _speedController.add((locationData.speed * 3.6).toInt().toString());
          if (accelerate) {
            whenAccelerate(locationData);
          } else {
            whenDeclerate(locationData);
          }
        });
      }
    });
  }

  void whenAccelerate(LocationData locationData) {
    if ((locationData.speed * 3.6) >= 10 &&
        (locationData.speed * 3.6) <= 30) {
      times.add(locationData.time);
    } else if ((locationData.speed * 3.6) < 10.0 && times.isNotEmpty) {
      times.clear();
    } else if ((locationData.speed * 3.6) > 30.0 && times.isNotEmpty) {
      print(times.first.toString() + "  " + times.last.toString());
      accTime = null;
      calcTime(times);
      times.clear();
      accelerate = false;
    }
  }

  void whenDeclerate(LocationData locationData) {
    if ((locationData.speed * 3.6) >= 10.0 &&
        (locationData.speed * 3.6) <= 30) {
      times.add(locationData.time);
    } else if ((locationData.speed * 3.6) > 30.0 && times.isNotEmpty) {
      times.clear();
    } else if ((locationData.speed * 3.6) < 10.0 && times.isNotEmpty) {
      print(times.first.toString() + "  " + times.last.toString());
      decTime = null;
      calcTime(times);
      times.clear();
      accelerate = true;
    }
  }

  // getSpeed() async {
  //   try {
  //     var myLocation = await _location.getLocation();
  //     mySpeed = (myLocation.speed * 3.6).toInt().toString();
  //   } on Exception catch (e) {
  //     mySpeed = e.toString();
  //   }

  //   notifyListeners();
  // }

  calcTime(List<double> times) {
    var times2 = times;
    if (accelerate) {
      if (accTime == null) {
        accTime = ((times2.last - times2.first) / 1000).round();
      }
    } else {
      if (decTime == null) {
        decTime = ((times2.last - times2.first) / 1000).round();
      }
    }
    notifyListeners();
  }
}
