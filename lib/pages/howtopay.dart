import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:davistar_media/helper/HexColorSupport.dart';

class HowtoPay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HowtoPayState();
  }
}

class HowtoPayState extends State<HowtoPay> {

  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: 'Step 1',
        styleTitle:
        TextStyle(color: Colors.black, ),
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        styleDescription:
        TextStyle(color: Colors.black,),
        pathImage: "images/slide1.png",
        backgroundColor: HexColor('#FFFFFF'),
      ),
    );
    slides.add(
      new Slide(
        title: "Step 2" ,
        styleTitle:
        TextStyle(color: Colors.black, ),
        description: "Ye indulgence unreserved connection alteration appearance",
        styleDescription:
        TextStyle(color: Colors.black,),
        pathImage: "images/slide2.png",
        backgroundColor: HexColor('#FFFFFF'),
      ),
    );
    slides.add(
      new Slide(
        title: "Step 3",
        styleTitle:
        TextStyle(color: Colors.black, ),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription:
        TextStyle(color: Colors.black,),
        pathImage: "images/slide3.png",
        backgroundColor: HexColor('#FFFFFF'),
      ),
    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: _aboutAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: AssetImage("images/backgroundmenu.jpg"), // Drawer Background Image edit here
            fit: BoxFit.cover,),
        ),
        child: new IntroSlider(
          slides: this.slides,

        ),
      ),
    );
  }
}

Widget _aboutAppBar() {
  return  AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title:Text(
        'About',
        style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(

          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              HexColor('#FFFFFF'),
              HexColor('#FFFFFF')
            ],
          ),
        ),
      ));
}