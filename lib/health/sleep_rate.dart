
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/sleep_rating.dart';

class SleepView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new SleepViewState();

}

class SleepViewState extends State<SleepView> {

  String _toBedTime = _formatTime(new TimeOfDay(hour: 9, minute: 30));
  String _toSleepTime = _formatTime(new TimeOfDay(hour: 9, minute: 30));
  String _wakeUpTime = _formatTime(new TimeOfDay(hour: 7, minute: 30));

  var _ratings = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  String _rating = '0';

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        body:new Container(

          child: new Column(
            children: <Widget>[

              _title(),
              _divider(),
              _wentToBed(),
              _whiteSpace(),
              _wentToSleep(),
              _whiteSpace(),
              _wokeUp(),
              _whiteSpace(),
              _quality()

            ],
          ),

        ),

        persistentFooterButtons: <Widget>[
          new FlatButton(
            onPressed: _saveEntry,
            child: new Text("Rate it"),
            color: Colors.green,
            textColor: Colors.white,)
        ],

      ),

    );

  }

  Widget _title() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[

        new Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: new Text("What did your sleep look like last night?", style: new TextStyle(fontSize: 18.0),)
        )

      ],

    );
  }

  Widget _wentToBed() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("Went to bed at", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: new RaisedButton(
              child: new Text(_toBedTime, style: new TextStyle(fontSize: 18.0),),
              onPressed: () {_selectBedTime(context);}
            ),
          ),
        )

      ],
    );

  }

  Widget _wentToSleep() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("Got to sleep at", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: new RaisedButton(
              child: new Text(_toSleepTime, style: new TextStyle(fontSize: 18.0),),
              onPressed: () {_selectSleepTime(context);}
            ),
          ),
        )

      ],
    );

  }

  Widget _wokeUp() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("Woke up at", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: new RaisedButton(
              child: new Text(_wakeUpTime, style: new TextStyle(fontSize: 18.0),),
              onPressed: () {_selectWakeUpTime(context);}
            ),
          ),
        )

      ],
    );

  }

  Widget _quality() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("How was the quality?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Column(

          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new DropdownButton<String>(

                  items: _ratings.map((String rating) {
                    return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

                  value: _rating,

                  onChanged: (String value) {
                    setState(() {
                      _rating = value;
                    });
                  },

                )
            ),
          ],
        )

      ],
    );

  }

  Future<Null> _selectBedTime(BuildContext context) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _toBedTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectSleepTime(BuildContext context) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _toSleepTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectWakeUpTime(BuildContext context) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _wakeUpTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _saveEntry() async {

    if(await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: new Text("Rate your sleep?"),
            children: <Widget>[

              new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      SimpleDialogOption(
                        onPressed: (){ Navigator.pop(context, true); },
                        child: new Text("Rate it", style: new TextStyle(color: Colors.green,),),
                      ),

                      SimpleDialogOption(
                        onPressed: (){ Navigator.pop(context, false); },
                        child: new Text("Nevermind"),
                      )

                    ],
                  )
                ],
              )

            ],
          );
      }
    ))
    {
      var ref = Database.sleepEntriesPushReference();

      SleepRating settings = new SleepRating(_toBedTime, _toSleepTime, _wakeUpTime, _rating);

      ref.set(settings.toJson());

      _confirm("Sleep rated successfully");
    }

  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 18.0,
      indent: 0.0,
    );
  }

  Widget _whiteSpace() {
    return new Divider(
      color: Colors.white,
      height: 15.0,
    );
  }

  void _confirm(String confirmation) {
    Utilities.showSnackbarMessage(context, confirmation);
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
