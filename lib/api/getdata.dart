import 'dart:convert';

import 'package:news/models/newsmodel.dart';
import 'package:http/http.dart' as http;

class getdata{


  Future<Newsmodal>news(String url)async{
    try{
      var respons = await http.get(url);
      var jsonstring = jsonDecode(respons.body);
      if(jsonstring['status']=='ok'){
        Newsmodal n = Newsmodal.fromJson(jsonstring);

        return n;

      }else{
        return null;
      }
    }catch(err){

      return null;
    }
  }
}