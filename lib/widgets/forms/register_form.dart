import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/res/custom_colors.dart';
import 'package:grocery_app/screens/authentication/sign_in_screen.dart';
import 'package:grocery_app/screens/authentication/email_verification_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/utils/auth_utils.dart';
import 'package:grocery_app/utils/auth_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_form_field.dart';

class EPRegisterForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const EPRegisterForm({
    Key? key,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);
  @override
  _EPRegisterFormState createState() => _EPRegisterFormState();
}

class _EPRegisterFormState extends State<EPRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();

  bool _isSingningUp = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EPSignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /* void _loadSharedPrefs() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("userName", _nameController.text.toString());
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _nameController,
                  focusNode: widget.nameFocusNode,
                  keyboardType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  isCapitalized: true,
                  validator: (value) => EPValidator.validateName(
                    name: value,
                  ),
                  label: 'Name',
                  hint: 'Enter your name',
                ),
                SizedBox(height: 16.0),
                CustomFormField(
                  controller: _emailController,
                  focusNode: widget.emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) => EPValidator.validateEmail(
                    email: value,
                  ),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                SizedBox(height: 16.0),
                CustomFormField(
                  controller: _passwordController,
                  focusNode: widget.passwordFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => EPValidator.validatePassword(
                    password: value,
                  ),
                  isObscure: true,
                  label: 'Password',
                  hint: 'Enter your password',
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
          _isSingningUp
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.primaryColor,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        widget.emailFocusNode.unfocus();
                        widget.passwordFocusNode.unfocus();

                        setState(() {
                          _isSingningUp = true;
                        });

                        if (_registerFormKey.currentState!.validate()) {
                          User? user =
                              await EPAuthentication.registerUsingEmailPassword(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          );

                          final prefs = await SharedPreferences.getInstance();
                          setState(() {
                            prefs.setString(
                                "userName", _nameController.text.toString());
                          });

                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => EPUserInfoScreen(
                                  user: user,
                                ),
                              ),
                            );
                          }
                        }

                        setState(() {
                          _isSingningUp = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 16.0),
          InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  _routeToSignInScreen(),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Already have an account? ',
                    ),
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .green, // You can also use a specific shade of green if you prefer
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
