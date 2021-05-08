import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProvData extends ChangeNotifier {
  void savedata(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('carddata', data);
  }

  get datafetched async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lfavrt = prefs.getString('carddata');
    var data = jsonDecode(lfavrt);
    return data;
  }
}
