import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_cubid.dart';
import '../../models/user_model.dart';
import '../../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home of ${user.username}"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor, kBlueColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '“The only way to do great work is to love what you do.” – Steve Jobs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
