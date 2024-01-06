import 'package:flutter/material.dart';
import 'package:grocery_app/res/custom_colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            width: double.maxFinite,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Creator: ',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.0,
                        color: Colors.white54,
                      ),
                      children: [
                        TextSpan(
                          text: 'Souvik Biswas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Powered by: ',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14.0,
                            color: Colors.white54,
                          ),
                          children: [
                            TextSpan(
                              text: 'Flutter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.0),
                      FlutterLogo(size: 20.0)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          height: 20.0,
          width: double.maxFinite,
        ),
      ],
    );
  }
}
