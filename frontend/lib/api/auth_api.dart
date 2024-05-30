import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../constains.dart';


Future<dynamic> userAuth(String email, String password) async {
  Map body = {
    // "username": "",
    "email": email,
    "password": password,
  };
  var url = Uri.parse("$baseUrl/user/auth/login/");
  var res = await http.post(url, body: body);

  print(res.body);
  print(res.statusCode);
  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['key'];
    var box = await Hive.openBox(tokenBox);
    box.put("token", token);
    User? user = await getUser(token);
    return user;
  } else {
    Map json = jsonDecode(res.body);
    print(json);
    if (json.containsKey("email")) {
      return json["email"][0];
    }
    if (json.containsKey("password")) {
      return json["password"][0];
    }
    if (json.containsKey("non_field_errors")) {
      return json["non_field_errors"][0];
    }
  }
}

Future<User?> getUser(String token) async {
  var url = Uri.parse("$baseUrl/user/auth/user/");
  var res = await http.get(
    url,
    headers: {
      'Authorization': 'Token $token',
    },
  );
  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    User user = User.fromJson(json);
    user.token = token;
    return user;
  } else {
    return null;
  }
}