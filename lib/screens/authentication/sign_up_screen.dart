import 'package:flutter/material.dart';
import 'package:grocery_app/res/custom_colors.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:grocery_app/widgets/app_bar_title.dart';
import 'package:grocery_app/widgets/forms/register_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EPRegisterScreen extends StatefulWidget {
  @override
  _EPRegisterScreenState createState() => _EPRegisterScreenState();
}

class _EPRegisterScreenState extends State<EPRegisterScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Determine if the keyboard is open by the presence of insets at the bottom.
    var keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    // Calculate the desired height of the logo when the keyboard is open.
    double logoHeight = keyboardIsOpen
        ? 80
        : 160; // Minimized logo height when keyboard is open.
    // Calculate the desired spacing above the title when the keyboard is open.
    double titleSpacing =
        keyboardIsOpen ? 10 : 20; // Reduced spacing when keyboard is open.

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
                    Row(), // Assuming this Row is meant to be here for other widgets
                    Expanded(
                      child: AnimatedContainer(
                        // This container animates its properties over a given duration.
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        // Use the available space, but allow for resize when the keyboard is up.
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
                                height: 160,
                              ),
                            ),
                            // Image.asset(
                            //   'assets/icons/freshrescue.png',
                            //   height: logoHeight, // Use animated logo height.
                            // ),
                            SizedBox(
                                height: titleSpacing), // Use animated spacing.
                            AnimatedDefaultTextStyle(
                              style: TextStyle(
                                fontFamily: gilroyFontFamily,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                fontSize: keyboardIsOpen
                                    ? 20
                                    : 40, // Adjust font size with animation.
                              ),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: Text(
                                'FreshRescue',
                              ),
                            ),
                            // ... Other widgets that you might want to include
                          ],
                        ),
                      ),
                    ),

                    EPRegisterForm(
                      nameFocusNode: _nameFocusNode,
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
