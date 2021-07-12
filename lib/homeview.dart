import 'package:davistar_media/pages/pay_instructions.dart';
import 'package:flutter/material.dart';
import 'package:davistar_media/uiscreens/trending.dart';
import 'package:davistar_media/uiscreens/inbox.dart';
import 'package:davistar_media/uiscreens/library.dart';
import 'package:davistar_media/uiscreens/trending.dart';
import 'package:davistar_media/screens/home_screen.dart';
import 'package:davistar_media/screens/home_screen2.dart';
import 'package:davistar_media/helper/Constant.dart';
import 'package:share/share.dart';
import 'package:app_review/app_review.dart';
import 'package:davistar_media/pages/live.dart';
import 'package:davistar_media/pages/howtopay.dart';
import 'package:davistar_media/pages/members.dart';
import 'package:davistar_media/pages/playlists.dart';
import 'package:davistar_media/pages/pay_instructions.dart';
import 'package:davistar_media/pages/shop.dart';
import 'package:davistar_media/pages/playlist/screens/playlists.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ViewMain extends StatefulWidget {
  @override
  _ViewMainState createState() => _ViewMainState();
}

class _ViewMainState extends State<ViewMain> {
  int _currentIndex = 0;

  _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      YoutubeScreen(),
      YoutubeScreen2(),
      Shop(),

      Playlists(),
    ];

    return Scaffold(
      appBar: _mainAppBar(),
      drawer: getDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          //image: new DecorationImage(
          //image: AssetImage("images/appbar.jpg"), // change App bar background image
          // fit: BoxFit.cover,
          // ),
          // To use Gradient Instead uncheck this section and quote the above
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[primary, secondary],
          ),
        ),

        child: BottomNavigationBar(
          currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            fixedColor: Colors.red,
            unselectedItemColor: Colors.white,
            onTap: _onTapped,
            items: [
              BottomNavigationBarItem(
                  title: Text("Home" ), icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  title: Text("News"), icon: Icon(Icons.whatshot)),

              BottomNavigationBarItem(
                  title: Text("Shop"), icon: Icon(Icons.mail)),
              BottomNavigationBarItem(
                  title: Text("Playlist"), icon: Icon(Icons.folder)),
            ]),
      ),
    );
  }

  Widget _mainAppBar() {
    return AppBar(
      title: Image.asset(
        'images/youtube_logo.png',
        width: 98.0,
        height: 22.0,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                      textDirection: direction,
                      // set this property
                      child: Live()),
                ));
          },
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.videocam, color: apptextcolor ),

              ),
              Text('Live Tv',
                style: TextStyle(color: apptextcolor),
              )
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),

      ],

    flexibleSpace: Container(
    decoration: BoxDecoration(
    //image: new DecorationImage(
    //image: AssetImage("images/appbar.jpg"), // change App bar background image
    // fit: BoxFit.cover,
    // ),
    // To use Gradient Instead uncheck this section and quote the above
    gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[primary, secondary],
    ),
    ),
    ));
  }

  Drawer getDrawer() {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  secondary,
                  primary
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.2, 0.9],
                tileMode: TileMode.clamp),
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                  width: 120.0,
                  height: 120.0,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image:  AssetImage("images/davistar.jpg")
                      )
                  )
              ),
              ListTile(
                  leading: Icon(Icons.home, color: apptextcolor),
                  title: Text(
                    'Home',
                    style: TextStyle(color: apptextcolor),
                  ),
                  ),
              ListTile(
                  leading: Icon(Icons.monitor, color: apptextcolor),
                  title: Text(
                    'Live TV',
                    style: TextStyle(color: apptextcolor),

                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(
                            textDirection: direction,
                            // set this property
                            child: Live(),
                          ),
                        ));
                  }
                  ),

              ListTile(
                  leading: Icon(Icons.favorite, color: apptextcolor),
                  title: Text(
                    'Members Only',
                    style: TextStyle(color: apptextcolor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Members(),
                          ),
                        );
                  }),
              Divider(),

              ListTile(
                  leading: Icon(Icons.attach_money, color: apptextcolor),
                  title: Text(
                    'Jinsi Ya Kulipa',
                    style: TextStyle(color: apptextcolor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: direction,
                              // set this property
                              child: PayInstructions()),
                        ));
                  }),

              Divider(),

              ListTile(
                  leading: Icon(Icons.share, color: apptextcolor),
                  title: Text(
                    'Share App',
                    style: TextStyle(color: apptextcolor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (Platform.isAndroid) {
                      Share.share('I am listening to-\n'
                          '$appname\n'
                          'https://play.google.com/store/apps/details?id=$androidPackage&hl=en');
                    } else {
                      Share.share('I am listening to-\n'
                          '$appname\n'
                          '$iosPackage');
                    }
                  }),

              ListTile(
                  leading: Icon(Icons.info, color: apptextcolor),
                  title: Text(
                    'About Us',
                    style: TextStyle(color: apptextcolor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: direction,
                              // set this property
                              child: TrendingScreen()),
                        ));
                  }),
              ListTile(
                  leading: Icon(Icons.star, color: apptextcolor),
                  title: Text(
                    'Rate App',
                    style: TextStyle(color: apptextcolor),
                  ),
                  onTap: () {
                    AppReview.requestReview.then((onValue) {});
                  }),
            ],
          )),
    );
  }

}
