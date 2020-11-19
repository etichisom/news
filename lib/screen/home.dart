
import 'package:carousel_slider/';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/api/getdata.dart';
import 'package:news/models/category.dart';
import 'package:news/models/newsmodel.dart';

import 'package:news/screen/article.dart';
import 'package:news/screen/cart.dart';

class Home extends StatefulWidget {



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String ur = 'https://newsapi.org/v2/top-headlines?country=ng&category=general&apiKey=baefea2b5ab345b4bed17fe80b793be3';

  List<Cartmodel> row = [
    Cartmodel(
        url: 'https://newsapi.org/v2/top-headlines?country=ng&category=sport&apiKey=baefea2b5ab345b4bed17fe80b793be3',
        cartname: "Sport",
        imageurl: "image/sport.jpeg"),
    Cartmodel(
        url: 'http://newsapi.org/v2/top-headlines?country=ng&category=business&apiKey=baefea2b5ab345b4bed17fe80b793be3',
        cartname: "Business",
        imageurl: "image/buss.jpeg"),
    Cartmodel(
        url: 'https://newsapi.org/v2/top-headlines?country=ng&category=technology&apiKey=baefea2b5ab345b4bed17fe80b793be3',
        cartname: "Technology",
        imageurl: "image/tech.jpeg"),
    Cartmodel(
        url: 'https://newsapi.org/v2/top-headlines?country=ng&category=entertainment&apiKey=baefea2b5ab345b4bed17fe80b793be3',
        cartname: "entertainment",
        imageurl: "image/e.jpeg"),
    Cartmodel(
        url: "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=baefea2b5ab345b4bed17fe80b793be3",
        cartname: "General",
        imageurl: "image/g.jpeg")
  ];
  getdata g;

  Future<Newsmodal> newsmodal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(




        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Blog', style: TextStyle(color: Colors.black)),
              Text("News", style: TextStyle(color: Colors.blue),)
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            slider(),
            Flexible(
              child: Container(


                child: FutureBuilder<Newsmodal>(
                  future: newsmodal,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                     return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      children: snapshot.data.articles.map((e) {
                        return makelist(context, e);
                      }).toList(),
                    );
                  },
                ),
              ),
            )

          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsmodal = getdata().news(ur);
  }

  Widget buidrow(List<Cartmodel> row, BuildContext context) {
    return Container(
      height: 80,
      color: Colors.blue.withOpacity(0.05),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: row.map((e) => cart(e)).toList(),
      ),
    );
  }

  Widget cart(Cartmodel e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(
              builder: (context) => Cart(url: e.url, cartname: e.cartname,)));
        },
        child: Container(
            width: 100,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                image: DecorationImage(
                    image: NetworkImage(e.imageurl), fit: BoxFit.fill)
            ),
            child: Center(child: Text(e.cartname, style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),))),
      ),
    );
  }

  Widget makelist(BuildContext context, Article e) {
    bool islike = true;
    if (e.urlToImage == null) {
      return SizedBox();
    } else if (e.content == null) {
      return SizedBox();
    } else if (e.title == null) {
      return SizedBox();
    }  else if (e.publishedAt == null) {
        return SizedBox();
  } else if (e.author == null) {
      return SizedBox();

    }else if (e.author.length >20) {
      return SizedBox();
    }
  else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Articleview(e.url)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset.fromDirection(0.1)
                  )
                ],
              ),


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(

                        children: [
                          Text('Source:', style: TextStyle(color: Colors.black)),
                          SizedBox(width: 5,),
                          Text(e.author, style: TextStyle(color: Colors.blue),)
                        ],
                      ),

                      subtitle: Row(

                        children: [
                          Text('Publish At:', style: TextStyle(color: Colors.black)),
                          SizedBox(width: 5,),
                          Text(e.publishedAt.toLocal().toString(), style: TextStyle(color: Colors.red),)
                        ],
                      ),
                    ),
                    Container(
                      width: 330,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: NetworkImage(e
                              .urlToImage), fit: BoxFit.fill)
                      ),

                    ),
                    Center(child: Text(e.title, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),)),
                    Center(child: Text(e.content, style: TextStyle(color: Colors.black45),)),

                  ],
                ),
              ),
            ),
          )
      );
    }
  }

  Widget slider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: CarouselSlider(

        options: CarouselOptions(
          height: 100,


          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeInOutSine,
          enlargeCenterPage: true,

          scrollDirection: Axis.horizontal,
        ),
        items: row.map((e) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>Cart(url:e.url,cartname: e.cartname,)));
                },
                child: Container(
                    width: 300,

                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(image: AssetImage(e.imageurl),
                            fit: BoxFit.fill),
                        color: Colors.blue
                    ),
                    child: Center(child: Text(e.cartname + ' News', style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 24),))),


              );
            },
          );
        }).toList(),
      ),
    );

  }
}
