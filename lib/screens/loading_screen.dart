import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

const appId = "13ced8aa99e42d2d6d87edb3eee890d6";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getData() async {
    GetLocation location = GetLocation();
    await location.getCurrentPosition();
    var getLat = location.latitude;
    var getLon = location.longitude;
    print(getLat);
    print(getLon);
    NetworkHelper networking = NetworkHelper(
        URL:
            "http://api.openweathermap.org/data/2.5/weather?lat=$getLat&lon=$getLon&appid=$appId&units=metric");

    var deCodedData = await networking.netWorkData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(getJsonData: deCodedData);
    }));
    print(deCodedData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
