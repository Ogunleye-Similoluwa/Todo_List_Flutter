

import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigReader{
 late final Map<String, dynamic> _config ;

  Future<void> initialize() async{
    final configString = await rootBundle.loadString("config.app_config.json");
    _config = json.decode(configString);
  }
  /// add new
  String getSecretKey(){
    return _config["secret_key"];
  }



}