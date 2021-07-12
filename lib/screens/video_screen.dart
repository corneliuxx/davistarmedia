import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:davistar_media/screens/home_screen.dart';
import 'package:davistar_media/screens/home_screen2.dart';
import 'package:davistar_media/models/channel_model.dart';
import 'package:davistar_media/models/video_model.dart';
import 'package:davistar_media/screens/video_screen.dart';
import 'package:davistar_media/services/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:overlay/overlay.dart';
import 'package:davistar_media/pages/live.dart';
import 'package:davistar_media/pages/members.dart';
import 'package:davistar_media/helper/HexColorSupport.dart';
import 'package:share/share.dart';
import 'package:davistar_media/helper/Constant.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  Channel _channel;

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC6ay3S1iIp-Jz8gD4nNYe-A');
    setState(() {
      _channel = channel;
    });
  }


  @override
  void initState() {
    super.initState();
    _initChannel();

    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }



  Widget _buildButtonColumn(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(
            icon,
            color: apptextcolor,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: apptextcolor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Container(
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

        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is Ready.');
                  },
                ),
              ),
            ),
            Container(


              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildButtonColumn(Icons.thumb_up, "54k"),
                  _buildButtonColumn(Icons.thumb_down, "234"),
                  GestureDetector(
                      onTap: () {
                    Navigator.pop(context);
                    if (Platform.isAndroid) {
                      Share.share('I am listening to-\n'
                          '$appname\n'
                          'https://play.google.com/store/apps/details?id=$androidPackage&hl=en');
                    } else {
                      Share.share('Watch this video on Davistar Mata Media -\n'
                          '$appname\n'
                          '$iosPackage');
                    }
                  },
                      child: _buildButtonColumn(Icons.share, "Share"),
                  ),
                  _buildButtonColumn(Icons.cloud_download, "Download"),
                  _buildButtonColumn(Icons.playlist_add, "Playlists"),
                ],
              ),
            ),
             Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                     bottom: BorderSide(color: Colors.grey, width: 0.5),
                             ),
                       ),
                     child: Row(
                    children: <Widget>[
                    Expanded(
                        child: ListTile(
                       leading: CircleAvatar(
                       backgroundImage: AssetImage("images/davistar.jpg"),
                         ),
                        title: Text(
                          "Davistar Mata", style: TextStyle(color: apptextcolor),
                             overflow: TextOverflow.ellipsis,
                                   ),
                            subtitle: Text("185,000 subscribers",style: TextStyle(color: apptextcolor)),
                              ),
                        ),

                          ],
                           ),
                      ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Text("Members Only Content",style: TextStyle(color: apptextcolor))),
                  GestureDetector(
                    onTap: () => _showDialog(context),
                    child: FlatButton.icon(

                        icon: Icon(
                          Icons.play_circle_filled,
                          color: apptextcolor,
                        ),
                        label: Text(
                          "Play Members Only Video",
                          style: TextStyle(color: apptextcolor),
                        )),
                  )


                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 240,
                child: IgnorePointer(
                  child: _buildWebView()
                ),
            ),
          ],
        ),
      ),
    );
  }
  _showDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Members Only'),
        content: new Text('This Content is only available for paid members go to members area to access(Maudhui haya yanapatikana kwa watumiaji waliolipia tu bonyeza "Members Area" kufungua '),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Cancel'),
          ),
          SizedBox(height: 16),
          new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: direction,
                        // set this property
                        child: Members()),
                  ));
            },

            child: new Text('Members Area'),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {

    return WebView(


      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://www.davistarmata.com/blog2',
    );
  }
  @override
  bool get wantKeepAlive => true;
}

