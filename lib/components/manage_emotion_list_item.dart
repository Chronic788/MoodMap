
import 'package:flutter/material.dart';

import '../pages/manage_view.dart';

class ManageEmotionListItem extends StatefulWidget {

  ManageViewState _viewStateReference;

  ManageEmotionListItem(ManageViewState viewStateReference);

  @override
  State<StatefulWidget> createState() => new ManageEmotionListItemState(this);

  void removeButtonPressed() {
    _viewStateReference.removeEmotion(this);
  }

}

class ManageEmotionListItemState extends State<ManageEmotionListItem> {

  ManageEmotionListItem _itemReference;

  String _emotionName = "Test";
  bool _tracking = false;

  ManageEmotionListItemState(ManageEmotionListItem _itemReference);

  @override
  Widget build(BuildContext context) {

    return new Container(
      color: Colors.yellow,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ///The name of the emotion
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(_emotionName),
                  ],
                ),
                ///The switch to track the emotion or not
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Switch(value: _tracking, onChanged: switchChanged),
                  ],
                ),
                ///The button to remove the emotion
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: _itemReference.removeButtonPressed,
                      child: new Icon(Icons.remove),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

  }

  void switchChanged(bool) {
    if(_tracking == true) {
      _tracking = false;
    } else {
      _tracking = true;
    }
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