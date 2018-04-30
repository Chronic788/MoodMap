
import 'package:flutter/material.dart';

import 'package:mood_map/components/ratable_list_item.dart';

class RateEmotionsView extends StatefulWidget {

  Function _navigateToCategories;
  Function _navigateToSpecifics;

  RateEmotionsView(this._navigateToCategories, this._navigateToSpecifics);

  @override
  State<StatefulWidget> createState() => new RateEmotionsViewState(this._navigateToCategories, this._navigateToSpecifics);

}

class RateEmotionsViewState extends State<RateEmotionsView> {

  Function _navigateToCategories;
  Function _navigateToSpecifics;

  RateEmotionsViewState(this._navigateToCategories, this._navigateToSpecifics);

  List<RatableListItem> _emotions = new List();

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        appBar: new AppBar(
          title: new Text("My emotions"),
          actions: <Widget>[
            new Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
              child: new RaisedButton(
                  onPressed: null,
                  child: new Text("Add From Pallete")),)
          ],
        ),

        body: new ListView(
          children: _emotions.map((RatableListItem item) {
            return item;
          }).toList()
        ),

        persistentFooterButtons: <Widget>[
            new FlatButton(onPressed: null, child: new Text("Save")),
            new FlatButton(onPressed: null, child: new Text("Save and Journal")),
            new FlatButton(onPressed: _navigateToSpecifics, child: new Text("Back"))
        ],
        
      ),
    );

  }

  void addEmotion() {
    setState(() {
      _emotions.add(new RatableListItem("Anger"));
    });
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