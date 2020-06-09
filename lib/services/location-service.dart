import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  Location _location = Location();

  

  StreamController<String>_speedController = StreamController<String>.broadcast();

  Stream<String> get speedStream => _speedController.stream;

  LocationService(){
    _location.changeSettings(accuracy: LocationAccuracy.navigation);
    _location.requestPermission().then((PermissionStatus permissionStatus) {
      if(permissionStatus == PermissionStatus.granted){
        _location.onLocationChanged.handleError((dynamic err){
          _speedController.add(err.toString());
        }).listen((LocationData locationData) {
        
            _speedController.add((locationData.speed * 3.6).toInt().toString());
            print((locationData.time));
            print(DateTime.now().millisecondsSinceEpoch);
          
        });
      } 
    });
  }

  Future<String> getSpeed() async {
    var mySpeed = '';
    try {
      var myLocation = await _location.getLocation();
      mySpeed = myLocation.speed.toInt().toString();
    } on Exception catch (e) {
      mySpeed = e.toString();
    }
    return mySpeed;
  }
  

}
