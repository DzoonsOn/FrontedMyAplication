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

Future<dynamic> registerUser(
    String username,
    String email,
    String password,
    String confirm_password,
    ) async {
  Map<String, dynamic> data = {
    "username": username,
    "email": email,
    "password1": password,
    "password2": confirm_password,
  };

  var url = Uri.parse("$baseUrl/user/auth/registration/");
  var res = await http.post(
    url,
    body: data,
  );

  // "key":"0ed6082de696dbf2671145344b6d7281024f6925"

  Map json = jsonDecode(res.body);
  print(res.body);
  if (res.statusCode == 200 || res.statusCode == 201) {
    if (json.containsKey("key")) {
      String token = json["key"];
      var check = await getUser(token);
      if (check != null) {
        User user = check;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    print(res.statusCode);
    if (json.containsKey("email")) {
      return json["email"][0];
    } else if (json.containsKey("password1")) {
      return json["password1"][0];
    } else if (json.containsKey("password2")) {
      return json["password2"][0];
    } else if (json.containsKey("username")) {
      return json["username"][0];
    }
    if (json.containsKey("non_field_errors")) {
      return json["non_field_errors"][0];
    }
  } else {
    return null;
  }
}