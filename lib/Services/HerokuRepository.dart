import 'dart:convert';

import 'package:herokuapp/Services/HerokuModel.dart';
import 'package:http/http.dart' as http;

class callApiHerokuPizza {
  HerokuApi() async {
    String url = 'https://forkify-api.herokuapp.com/api/search?q=pizza#';
    var result = await http.get(Uri.parse(url));
    if(result.statusCode == 200){
      final json = result.body;
      print(json.toString());
      Map<String, dynamic> map = jsonDecode(json);
      return HerokuPizza.fromJson(map);
    }
    else {
      throw Exception("not found");
    }
  }
}