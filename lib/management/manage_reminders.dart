import 'package:flutter/material.dart';
import 'dart:async';

class ManageRemindersView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageRemindersViewState();

}

class ManageRemindersViewState extends State<ManageRemindersView> {

  var _interval = ["Daily", "Hourly", "Every 30 Minutes", "Every 15 Minutes"];
  String _intervalValue = "Daily";

  bool _remindingEmotions;
  bool _remindingSleep;
  bool _remindingExercise;

  String _emotionsTime = _formatTime(new TimeOfDay(hour: 9, minute: 30));
  String _sleepTime = _formatTime(new TimeOfDay(hour: 9, minute: 30));
  String _exerciseTime = _formatTime(new TimeOfDay(hour: 7, minute: 30));

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new SingleChildScrollView (
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            _buildEmotionSettings(),
            _divider(),
            _buildSleepSettings(),
            _divider(),
           _buildExerciseEvents()
         ],
       ),
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: null, child: new Text("Save", style: new TextStyle(color: Colors.green),))
      ],

    );

  }

  Widget _buildEmotionSettings() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Text("Emotion Reminders", style: new TextStyle(fontSize: 22.0),),
                ),),
            new Column(children: <Widget>[
              new Switch(value: true, onChanged: (bool on) { _remindingEmotions = on; })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Remind me", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new DropdownButton<String>(

                  value: _intervalValue,

                  items: _interval.map((String time) {
                    return new DropdownMenuItem<String>(value: time, child: new Text(time));
                  }).toList(),

                  onChanged: (String time) {
                    setState(() {
                      _intervalValue = time;
                    });
                  }

              ),
            )

          ],
        ),
        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("starting at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_emotionsTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectEmotionTime(context, _emotionsTime);}
                    ),
              ),
            )

          ],
        ),

      ],
    );

  }

  Widget _buildSleepSettings() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text("Sleep Reminders", style: new TextStyle(fontSize: 22.0),),
              ),),
            new Column(children: <Widget>[
              new Switch(value: true, onChanged: (bool on) { _remindingSleep = on; })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Rate in the morning at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_sleepTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectSleepTime(context, _sleepTime);}
                ),
            ),


          ],
        ),

      ],
    );

  }

  Widget _buildExerciseEvents() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text("Exercise Reminders", style: new TextStyle(fontSize: 22.0),),
              ),),
            new Column(children: <Widget>[
              new Switch(value: true, onChanged: (bool on) { _remindingExercise = on; })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Rate in the evening at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new RaisedButton(
                  child: new Text(_exerciseTime, style: new TextStyle(fontSize: 18.0),),
                  onPressed: () {_selectSleepTime(context, _exerciseTime);}
              ),
            ),


          ],
        ),

      ],
    );

  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 18.0,
      indent: 0.0,
    );
  }

  Future<Null> _selectEmotionTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _emotionsTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectSleepTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _sleepTime = _formatTime(picked);
      });
    }

  }

  static String _formatTime(TimeOfDay time) {
    var buffer = new StringBuffer();

    buffer.write(time.hourOfPeriod);
    buffer.write(":");
    buffer.write(time.minute);
    buffer.write(" ");

    if(time.period == DayPeriod.am) {
      buffer.write("AM");
    } else {
      buffer.write("PM");
    }

    return buffer.toString();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}