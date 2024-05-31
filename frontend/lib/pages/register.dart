import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/api/auth_api.dart';
import '../fields/home/home_page.dart';
import '../models/user_cubid.dart';
import '../models/user_model.dart';
import '../theme.dart';
import '../fields/fields.dart';
import '../fields/text_button.dart';
import 'login.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              "Hello user!\n Register for our application",
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CustomField(
            // iconUrl: 'assets/icon_name.png',
            hint: 'Username',
            controller: usernameController,
          ),
          CustomField(
            // iconUrl: 'assets/icon_email.png',
            hint: 'Email',
            controller: emailController,
          ),
          CustomField(
            // iconUrl: 'assets/icon_password.png',
            hint: 'Password',
            controller: passwordController,
            obsecure: true,
          ),
          CustomField(
            // iconUrl: 'assets/icon_password.png',
            hint: 'Confirm password',
            controller: confirm_passwordController,
            obsecure: true,
          ),
          CustomTextButton(
            title: 'Register',
            margin: EdgeInsets.only(top: 50),
            onTap: () async {
              var authRes =  await registerUser(usernameController.text, emailController.text, passwordController.text, confirm_passwordController.text);
              if(authRes.runtimeType == String){
                showDialog(context: context, builder: (context){
                  return Dialog(
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 250,
                      decoration: BoxDecoration(), child: Text(authRes),
                    ),
                  );
                });
              }
              else if(authRes.runtimeType == User){
                User user = authRes;
                context.read<UserCubit>().emit(user);
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return HomePage();
                },
                ));
              }
            } ,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text(
                    "Log in",
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}