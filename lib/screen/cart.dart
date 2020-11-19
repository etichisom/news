import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/api/getdata.dart';
import 'package:news/models/newsmodel.dart';

import 'article.dart';

class Cart extends StatefulWidget {
  String url;
  String cartname;

  Cart({this.url, this.cartname});



  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<Newsmodal> newsmodal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.cartname,style: TextStyle(color: Colors.black)),

            ],
          ),
          elevation: 0.0,

      ),

      body:  Container(
        color: Colors.blue.withOpacity(0.09),
       height: MediaQuery.of(context).size.height,
        child: FutureBuilder<Newsmodal>(
          future: newsmodal,
          builder: (context,snapshot){
            if(snapshot.data == null){
             return   Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.articles.map((e){

                return makelist(context, e);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
  Widget makelist(BuildContext context, Article e) {
    if(e.urlToImage == null){
      return SizedBox();
    }else if(e.content == null){
      return SizedBox();
    }else if(e.title == null){
      return SizedBox();
    }else if (e.author  == null) {
      return SizedBox();
    }else if (e.author.length >20) {
      return SizedBox();
    }
    else {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>Articleview(e.url)));
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
                          Text(e.author.substring(0,5), style: TextStyle(color: Colors.redAccent),)
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
                      ),),
                    Center(child: Text(e.title, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),)),
                    Center(child: Text(e.content, style: TextStyle(color: Colors.blue),)),

                  ],
                ),
              ),
            ),
          )
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsmodal = getdata().news(widget.url);


  }
}
