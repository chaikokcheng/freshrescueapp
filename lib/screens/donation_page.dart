import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account_items_page.dart';
import 'package:grocery_app/screens/home/home_banner_widget.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import 'category_items_screen.dart';

class DonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  getHeader(),
                  Divider(
                    thickness: 1,
                  ),

                  // Image.asset(
                  //   'assets/icons/freshrescue.png',
                  //   height: 80,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16,
                        bottom:
                            5), // This will add padding all around the stack
                    child: Text(
                      'Don’t throw,   Donate them',
                      style: TextStyle(
                        color: Color(0xFF005C19),
                        fontSize: 39,
                        fontFamily: gilroyFontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16,
                        right:
                            16), // This will add padding all around the stack
                    child: Text(
                      'Your heartwarming action can light up the lives of those in need. Donate food & money, and make a difference today!',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: gilroyFontFamily,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(
                        16.0), // Add padding around the container if needed
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.9, // Limit the width to 90% of the screen width
                      maxHeight: 300, // Limit the height to 200 logical pixels
                    ),
                    child: Image.asset(
                      'assets/images/pages/donation_banner.png',
                      fit: BoxFit
                          .contain, // This ensures the image maintains its aspect ratio
                    ),
                  ),

                  // Divider(
                  //   thickness: 1,
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Our Partner Organisations',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        16.0), // This will add padding all around the stack
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                            'assets/images/pages/donation_organisation1.png'),
                        Positioned(
                          bottom: 20, // Adjust the position as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DonateFood(),
                                  ));
                                },
                                child: Text("Donate Food",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15), // Adjust to your needs
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DonateCash(),
                                  ));
                                },
                                child: Text("Donate Money",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 236, 164, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15), // Adjust to your needs
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        16.0), // This will add padding all around the stack
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                            'assets/images/pages/donation_organisation2.png'),
                        Positioned(
                          bottom: 20, // Adjust the position as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DonateFood(),
                                  ));
                                },
                                child: Text("Donate Food",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15), // Adjust to your needs
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DonateCash(),
                                  ));
                                },
                                child: Text("Donate Money",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 236, 164, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15), // Adjust to your needs
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Center(
          child: AppText(
            text: "Donation",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        // Text(
        //   "See All",
        //   style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: AppColors.primaryColor),
        // ),
      ],
    );
  }
}

class DonateFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Donation'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/donation_food.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50.0,
              margin: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  _showEnrollDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text("Donate"),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showEnrollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Donated'),
          content: Text('Thanks for your donation!'),
          actions: [
            TextButton(
              child: Text(
                'done',
                selectionColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class DonateCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Donation'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/donation_cash.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50.0,
              margin: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  _showEnrollDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text("Donate"),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showEnrollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Donated'),
          content: Text('Thanks for your donation!'),
          actions: [
            TextButton(
              child: Text(
                'done',
                selectionColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
