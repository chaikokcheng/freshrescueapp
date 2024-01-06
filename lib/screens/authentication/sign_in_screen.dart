import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/res/custom_colors.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:grocery_app/widgets/forms/sign_in_form.dart';
import 'email_verification_screen.dart';

class EPSignInScreen extends StatefulWidget {
  @override
  _EPSignInScreenState createState() => _EPSignInScreenState();
}

class _EPSignInScreenState extends State<EPSignInScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EPUserInfoScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    var keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    double logoHeight = keyboardIsOpen ? 80 : 160;
    double titleSpacing = keyboardIsOpen ? 10 : 20;

    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        height: keyboardIsOpen
                            ? MediaQuery.of(context).size.height / 2
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/icons/freshrescue.png',
                                height: logoHeight,
                              ),
                            ),
                            SizedBox(height: titleSpacing),
                            AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontFamily: gilroyFontFamily,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                fontSize: keyboardIsOpen ? 20 : 40,
                              ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Text('FreshRescue'),
                            ),
                            Text(
                              ' ',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    EPSignInForm(
                      emailFocusNode: _emailFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
