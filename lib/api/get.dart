import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi_pratice/model/newsapi.dart';

import '../program.dart';
class GetApi {

  static Future<newsapi?> getnewsdata(BuildContext context) async {
    try {
      http.Response data = await http.get(
          Uri.parse(Program.baseurl + "&apikey=" + Program.apikey),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }
      );

      var jsondata = jsonDecode(data.body);
      var newsdata = newsapi.fromJson(jsondata);
      return newsdata;
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}