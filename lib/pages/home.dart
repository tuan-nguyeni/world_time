import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/context_data.dart';
import '../models/context_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataModel data = DataModel(time: '', location: '', isDaytime: true, flag: '');

  @override
  Widget build(BuildContext context) {
    Object? objectData = data.location!='' ? data : ModalRoute.of(context)?.settings.arguments;

    if (objectData is DataModel) {
      data = objectData;
    } else {
      objectData= objectData as Map;
      data  =  DataModel(
        location: objectData['location'],
        flag: objectData['flag'],
        time: objectData['time'],
        isDaytime: objectData['isDaytime'],
      );
    }
    // set background image
    String bgImage = data.isDaytime ? 'day.png' : 'night.png';
    Color? bgColor = data.isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = DataModel(
                          time: result['time'],
                          location: result['location'],
                          isDaytime: result['isDaytime'],
                          flag: result['flag'],
                        );
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data.location,
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data.time,
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
