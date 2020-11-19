

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news/models/newsmodel.dart';
import 'package:news/screen/home.dart';

import 'api/getdata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: Splash(),
    );
  }

}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String ur = 'https://newsapi.org/v2/top-headlines?country=ng&category=general&apiKey=baefea2b5ab345b4bed17fe80b793be3';
  Future<Newsmodal> n;
  bool data = false;
  BuildContext contex;

  @override
  Widget build(BuildContext context) {
    contex = context;
    return Scaffold(

      body: Center(
       child: SizedBox(
         width: 250.0,
         child: ScaleAnimatedTextKit(
             onTap: () {
               print("Tap Event");
             },
             text: [
               "Blog",
               "News",

             ],
             textStyle: TextStyle(
                 fontSize: 70.0,

                 fontFamily: "Canterbury"
             ),
             textAlign: TextAlign.start,
             alignment: AlignmentDirectional.topStart // or Alignment.topLeft
         ),
       )
        ,
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nav();

  }
  nav()async{
    Future.delayed(Duration(seconds: 6),(){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (contex)=>Home()));
    });
  }
}


