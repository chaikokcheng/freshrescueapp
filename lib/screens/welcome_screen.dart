import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/authentication/sign_in_screen.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/screens/onboarding/onboarding_screen.dart';
import 'package:grocery_app/screens/authentication/email_verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isUserSignedIn = false;
  late User _user;
  bool _isUserRegisteredStatus = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase().then((firebaseApp) {
      _checkUserRegisteredStatus().then((isRegistered) {
        Timer(Duration(seconds: 2), () {
          setState(() {
            _showButton = true;
          });
          if (_isUserSignedIn) {
            if (_isUserRegisteredStatus) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(
                      // user: _user,
                      // userEmailID: _user.email.toString(),
                      // userDisplayName: _user.displayName.toString(),
                      ),
                ),
              );
            }
            //   else {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => WelcomeScreen(),
            //       ),
            //     );
            //   }
            // } else {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (context) => WelcomeScreen()),
            //   );
          }
        });
      });
    });
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        _isUserSignedIn = true;
        _user = currentUser;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userEmail", _user.email.toString());
      await prefs.setString("userDisplayName", _user.displayName.toString());
    }

    return firebaseApp;
  }

  Future<bool> _checkUserRegisteredStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isUserRegisteredStatus = prefs.getBool("userRegisteredStatus") ?? false;
    return _isUserRegisteredStatus;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                Image.asset("assets/icons/freshrescue.png"),
                SizedBox(
                  height: 20,
                ),
                welcomeTextWidget(),
                SizedBox(
                  height: 10,
                ),
                sloganText(),
                SizedBox(
                  height: 40,
                ),
                getButton(context),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ));
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "FreshRescue",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
        AppText(
          text: "Less Waste, More Taste",
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    // Use a ternary operator to conditionally display the button or an empty space
    return _showButton
        ? AppButton(
            label: "Get Started",
            fontWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(vertical: 25),
            onPressed: () {
              onGetStartedClicked(context);
            },
          )
        : SizedBox(
            height:
                50); // Adjust the height as needed to match your button's height
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return EPSignInScreen();
      },
    ));
  }
}
