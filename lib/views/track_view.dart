
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/emotion_tracking/emotion_tracking_view.dart';
import 'package:mood_map/tracking/health_tracking/health_tracking_view.dart';

class TrackView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new TrackViewState();

}

class TrackViewState extends State<TrackView> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

        labelColor: Colors.black,

        controller: _tabController,
        tabs: <Widget>[
          new Tab(text: "Emotions",),
          new Tab(text: "Health",)
        ],

      ),

      body: new TabBarView(
        controller: _tabController,

        children: <Widget>[

          new EmotionTrackingView(),
          new HealthTrackingView()

        ],

        physics: NeverScrollableScrollPhysics(),

      ),

    );

  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


}
