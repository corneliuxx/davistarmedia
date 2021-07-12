import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:icon_shadow/icon_shadow.dart';

import 'package:davistar_media/helper/HexColorSupport.dart';
//import 'package:epicwebview/pages/About2.dart';
//import 'package:launch_review/launch_review.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:epicwebview/helpers/ad_manager.dart';
//import 'About.dart';

export 'package:webview_flutter/webview_flutter.dart' hide WebView;

class Shop extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return new ShopState();
  }
}

class ShopState extends State<Shop> {
  //SharedPref sharedPref = SharedPref();




  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  WebViewController _webViewController;

  bool isLoading;

  final Set<Factory<OneSequenceGestureRecognizer>> _gSet = Set()
    ..addAll([
      Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()),
      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
      Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
    ]);

  // TODO: Implement _loadBannerAd()


  @override
  void dispose() {
    // TODO: Dispose BannerAd object


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var bottomPadding = mediaQueryData.padding.bottom;

    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed(context);
      },
      child: Container(
          decoration: BoxDecoration(color: HexColor("#F51818")),
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Scaffold(
            key: _scaffoldKey,

            body: ModalProgressHUD(
                child: WebView(
                  userAgent:
                  'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
                  onWebViewCreated: (WebViewController controller) {
                    _webViewController = controller;
                  },
                  gestureRecognizers: _gSet,
                  initialUrl: 'https://davistarmata.com/shop-2/',
                  javascriptMode: JavascriptMode.unrestricted,
                  //javascriptChannels: tempJavascriptChannels,
                  onPageStarted: (String url) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                    );

                    this.setState(() {
                      isLoading = false;
                    });
                  },

                  gestureNavigationEnabled: true,
                  navigationDelegate: (NavigationRequest request) async {
                    if (request.url.contains("mailto:") ||
                        request.url.contains("tel:") ||
                        request.url.contains("sms:") ||
                        request.url.contains("intent://") ||
                        request.url.contains('.pdf')) {
                      if (await canLaunch(request.url)) {
                        await launch(request.url);
                      } else {
                        if (Platform.isAndroid &&
                            request.url.contains("intent://")) {
                          String id = request.url.substring(
                              request.url.indexOf('id%3D') + 5,
                              request.url.indexOf('#Intent'));
                          await StoreRedirect.redirect(androidAppId: id);
                          if (await _webViewController.canGoBack()) {
                            _webViewController.goBack();
                          }
                        }
                      }
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
                inAsyncCall: isLoading),
          )),
    );
  }

  @override
  void initState() {
    // TODO: Initialize _bannerAd
    isLoading = true;

    // TODO: Load a Banner Ad

  }

  int parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;

    return int.tryParse(value) ?? null;
  }

//When You go back too many times this calls the "are you sure " dialog

  Future<bool> _onBackPressed(context) async {
    try {
      if (_webViewController != null) {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          _showDialog(context);
        }
      }
    } catch (e) {
      _showDialog(context);
    }
  }

// Exit app dialog box appears when you go back too many times
  _showDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Exit Members Area'),
        content: new Text('Are you sure want to leave members area ? (Je unataka kutoka Kwenye members area'),
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
            },

            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

// Share App Dialog BOx
  shareApp(BuildContext context, String text, String share) {
    final RenderBox box = context.findRenderObject();
    Share.share(share,
        subject: text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

//App bar  change appbar background image here

Widget _mainAppBar() {
  return AppBar(
      title: Text(
        'Exit Members area',
        style: TextStyle(
            color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
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
            colors: <Color>[HexColor('#021e39'), HexColor('#000000')],
          ),
        ),
      ));
}
