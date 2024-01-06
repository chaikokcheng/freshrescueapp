import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account_items_page.dart';
import 'package:grocery_app/screens/home/home_banner_widget.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import 'category_items_screen.dart';

class RecipeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/challengepage.png',
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
                child: Text("Join"),
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
          title: Text('Joined'),
          content: Text('You can post your recipe in challenge page now!'),
          actions: [
            TextButton(
              child: Text(
                'Go',
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

class ChallengeLeaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/challenge_leaderboardpage.png',
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
              // child: ElevatedButton(
              //   onPressed: () {
              //     _showEnrollDialog(context);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: AppColors.primaryColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   child: Text("Add Product"),
              // ),
            ),
          )
        ],
      ),
    );
  }
}

class CommunityScreen extends StatelessWidget {
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

                  HomeBanner(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // To space out the buttons evenly
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreatePost(),
                          ));
                        },
                        child: Text("Create a post",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15), // Adjust to your needs
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChallengeLeaderboard(),
                          ));
                        },
                        child: Text("Leaderboard",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Color.fromARGB(255, 236, 164, 89),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15), // Adjust to your needs
                        ),
                      ),
                    ],
                  ),
                  // Divider(
                  //   thickness: 1,
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Latest posts ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChallengePost1(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.asset(
                        'assets/images/pages/challenge_post1.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between images
                  // Clickable image for challenge_post2
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChallengePost2(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.asset(
                        'assets/images/pages/challenge_post2.png',
                        fit: BoxFit.fitWidth,
                      ),
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
            text: "Challenge",
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

class ChallengePost1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jeremy L's post"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/challenge_post1content.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: double.infinity,
          //     height: 50.0,
          //     margin: EdgeInsets.all(20.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         _showEnrollDialog(context);
          //       },
          //       style: ElevatedButton.styleFrom(
          //         primary: AppColors.primaryColor,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //       child: Text("Join"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class ChallengePost2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hooi Yang's post"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/challenge_post2content.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: double.infinity,
          //     height: 50.0,
          //     margin: EdgeInsets.all(20.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         _showEnrollDialog(context);
          //       },
          //       style: ElevatedButton.styleFrom(
          //         primary: AppColors.primaryColor,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //       child: Text("Join"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class CreatePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a post"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/createpostpage.png',
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
                child: Text("Post"),
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
          title: Text('Posted'),
          content: Text('Your post is uploaded'),
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
