import 'dart:convert';

import 'package:dioapi/Const/constants.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // create a async method to get data from API

  Future getWeather() async {
    // use try catch block for any exception
    try {
      // response store data in json format
      // dio use get property to fetch data it should take some time so make it with await
      // we are weatherapi's API it free you can use what ever you want
      // currently we are doing that to fetch user current location and share data according
      // we are using some demo  text that start our api data
      var response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?key=68ea3b75c9c2462787e52106211203&q=$location&aqi=yes');
      Map<String, dynamic> data = jsonDecode(response.toString());
      // jsonDecode convert data into string for  further use by using MAP property

      setState(() {
        // country and city  name that print in App Bar
        country = data['location']['country'].toString();
        location = data['location']['name'].toString();
        // to be so sure it should be as string type

        temp = data['current']['temp_c'].round();
        // round method convert double value into integer

// local time according to location that searched
        time = data['location']['localtime'].toString();
        // temperature in far
        tempf = data['current']['temp_f'].round();
        humidity = data['current']['humidity'].round();
        wind = data['current']['wind_kph'].round();
        // we are using two property to get icon according to weather codition
        // API return unfinished link of icon that why we are using
        cacheIcon = data['current']['condition']['icon'].toString();
        src = 'https:' + cacheIcon; // this to combine and get propper icon

        print(data.toString());
        // print data into consol
      });
    } on Exception catch (e) {
      print(e.toString().toUpperCase());
    }
  }

// using init method to initialize our typed location to run at starting time of app

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height.toDouble();
    print('===========  Re Created  ==============');
    return Container(
      decoration: BoxDecoration(
        // background color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 1.6],
          colors: [
            Color(0xff0e1e29),
            Color(0xff5292a4),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: buildTextField(),
                    width: size.width / 1.6,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        location = controller.text;
                      });
                      getWeather();
                    },
                  )
                ],
              ),
            ),
            buildWeatherIcon(),
            buildTempField(height),
            buildRowData(
              data: tempf.toString() + ' f',
              icon: 'assets/far.png',
              text: 'Temp in F',
            ),
            SizedBox(height: 10),
            buildRowData(
              data: humidity.toString() + ' %',
              icon: 'assets/humidity.png',
              text: 'Humidity',
            ),
            SizedBox(height: 10),
            buildRowData(
              data: wind.toString() + ' Kph',
              icon: 'assets/wind.png',
              text: 'Wind',
            ),
            SizedBox(height: 10),
            Divider(thickness: 2),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

// Icon represent according to Climate
  Image buildWeatherIcon() {
    return Image.network(
      src,
      height: 70,
      width: 70,
      fit: BoxFit.cover,
    );
  }

// Data Like Temp in farenheit, wind speed
  Row buildRowData({
    String icon,
    String text,
    String data,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          icon,
          height: 40,
          width: 40,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
        Text(
          text,
          style: customGrey,
        ),
        Text(
          data,
          style: customGrey,
        ),
      ],
    );
  }

// Temperature Display
  FittedBox buildTempField(double height) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Row(
        children: [
          Text(
            temp.toString(),
            style: TextStyle(fontSize: height / 8, color: Colors.white),
          ),
          SizedBox(width: 5),
          Text(
            '°C',
            style: TextStyle(
              fontSize: height / 8.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

// Search Bar
  TextField buildTextField() {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search City',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

// App Bar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              getWeather();
              // on referesh  weather get updated 
            });
          },
        ),
      ],
      title: appData(),
    );
  }


// Text Fields of App Bar 
  Column appData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time.toString(),
          // time 
          style: smallText,
        ),
        SizedBox(height: 7),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            children: [
              Icon(
                Icons.room,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 5),
              // location
              Text(
                location.toString() + " ," + country.toString().toUpperCase(),
                style: smallText.copyWith(
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
