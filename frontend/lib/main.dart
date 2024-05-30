import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user_cubid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return UserCubit(User());
        },
        child: MaterialApp(
          title: 'Leżaczek',
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: const SignInPage(),
        ));
  }
}
