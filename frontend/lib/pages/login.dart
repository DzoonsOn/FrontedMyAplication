import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/api/auth_api.dart';
import 'package:frontend/fields/home/home_page.dart';
import 'package:frontend/pages/register.dart';
import '../models/user_cubid.dart';
import '../models/user_model.dart';
import '../theme.dart';
import '../fields/fields.dart';
import '../fields/text_button.dart';
import 'forget_password.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          // horizontal: 5,
        ),
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 50),
          //   child: Image.asset(
          //     'assets/img_login.png',
          //   ),
          // ),
          SizedBox(
            height: 150,
          ),
          CustomField(
            controller: emailController,
            // iconUrl: 'assets/icon_email.png',
            hint: 'Email',
          ),
          CustomField(
            controller: passwordController,
            // iconUrl: 'assets/icon_password.png',
            hint: 'Password',
            obsecure: true,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassPage()),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
          ),
          //login
          CustomTextButton(
            onTap: () async {
              var authRes = await userAuth(emailController.text, passwordController.text);
              if (authRes.runtimeType == String) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded corners
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 250,
                        padding: EdgeInsets.symmetric(vertical: 20), // Adjust vertical padding
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.circular(20), // Ensures rounded corners
                        ),
                        child: Text(
                          authRes,
                          style: TextStyle(fontSize: 18), // Increased font size
                          textAlign: TextAlign.center, // Center align the text
                        ),
                      ),
                    );
                  },
                );
              } else if (authRes.runtimeType == User) {
                User user = authRes;
                context.read<UserCubit>().emit(user);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ));
              }
            },
            title: 'Login',
            margin: EdgeInsets.only(top: 50),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register now.",
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
