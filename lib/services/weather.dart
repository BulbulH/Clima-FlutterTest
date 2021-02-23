import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const appId = "13ced8aa99e42d2d6d87edb3eee890d6";

class WeatherModel {
  Future<dynamic> getCityWeather(cityname) async {
    NetworkHelper networking = NetworkHelper(
        URL:
            "http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=13ced8aa99e42d2d6d87edb3eee890d6&units=metric");
    var deCodedData = await networking.netWorkData();
    return deCodedData;
  }

  Future getLOcationData() async {
    GetLocation location = GetLocation();
    await location.getCurrentPosition();
    var getLat = location.latitude;
    var getLon = location.longitude;
    // var getLat = 35;
    // var getLon = 139;
    //print(getLat);
    //print(getLon);

    NetworkHelper networking = NetworkHelper(
        URL:
            "http://api.openweathermap.org/data/2.5/weather?lat=$getLat&lon=$getLon&appid=$appId&units=metric");
    var deCodedData = await networking.netWorkData();
    return deCodedData;
  }

  WeatherModel({this.condition});
  final condition;
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
