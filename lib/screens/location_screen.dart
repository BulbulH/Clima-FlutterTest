import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.getJsonData});

  final getJsonData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherMessage = WeatherModel();
  double tempareture;
  var city;
  var condition;
  var message;
  var wIcon;
  String msgTxt = 'in';
  bool loading = true;

  void UpdateUI(dynamic weatheData) {
    //print(weatheData);
    setState(() {
      loading = false;
      if (weatheData == null) {
        tempareture = 0;
        wIcon = "Eror!";
        message = 'Put A valid City Name';
        msgTxt = '';
        return;
      }
      tempareture = double.parse(weatheData["main"]["temp"].toString());
      //tempareture = int.parse(tempareture.toStringAsFixed(0));
      condition = weatheData["weather"][0]["id"];
      city = weatheData["name"];
      wIcon = weatherMessage.getWeatherIcon(condition);
      message = weatherMessage.getMessage(tempareture);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateUI(widget.getJsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        var newLocationData =
                            await weatherMessage.getLOcationData();
                        UpdateUI(newLocationData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          setState(() {
                            loading = true;
                          });
                          var cityWeatherData =
                              await weatherMessage.getCityWeather(typedName);
                          UpdateUI(cityWeatherData);
                          print(cityWeatherData);
                        } else {
                          print("null");
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${tempareture.toStringAsFixed(0)}°",
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$wIcon️',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message $msgTxt $city!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        loading
            ? Container(
                color: Colors.black.withOpacity(0.65),
                child: Center(
                  child: SpinKitWave(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              )
            : Container(),
      ],
    ));
  }
}
