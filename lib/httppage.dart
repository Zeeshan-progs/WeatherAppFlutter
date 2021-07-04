import 'dart:convert';

// import 'package:dioapi/Content/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Content/Constants.dart';



class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  // create a future

  Future getResponse() async {
    // method must be async for future content

    // we have to pass a link in string format
    http.Response response = await http.get(
        'https://api.weatherapi.com/v1/current.json?key=68ea3b75c9c2462787e52106211203&q=$location&aqi=yes');
    // convert json data to
//convert data must be stored in a Map formate

    Map<String, dynamic> result = jsonDecode(response.body.toString());
    setState(() {
      //temp_c return double type value and we are using round method to remove decimal value

      temp = result['current']['temp_c'].round();
      location = result['location']['name'];
      country = result['location']['country'];
    });
    print(result.toString().toUpperCase());
  }

  @override
  void initState() {
    this.getResponse();
    super.initState();
  }

// as we have seen in our ui from last video we can set data Accordingly
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  location + ', ' + country,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  temp.toString(),
                  style: customGrey,
                ),
                // like this you can get all the data that you needs
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// thats it for today 


// thank you 
