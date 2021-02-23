import 'package:geolocator/geolocator.dart';

class GetLocation {
  var latitude;
  var longitude;
  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    //print(latitude);
    //print(longitude);
  }
}
