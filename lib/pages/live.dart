import 'package:davistar_media/helper/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:webview_flutter/webview_flutter.dart';

class Live extends StatefulWidget {


  LiveState createState() => LiveState();
}

class LiveState extends State<Live>
    with AutomaticKeepAliveClientMixin<Live> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _mainAppBar(),
        body: _buildWebView(),
        );
  }

  Widget _mainAppBar() {
    return AppBar(
        title: Text(
          'Live Tv',
          style: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.grey),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: apptextcolor),
          onPressed: () => Navigator.of(context).pop(),
        ) ,
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

  Widget _buildWebView() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://www.youtube.com/embed/live_stream?channel=UC6ay3S1iIp-Jz8gD4nNYe-A',
    );
  }
  @override
  bool get wantKeepAlive => true;
}
