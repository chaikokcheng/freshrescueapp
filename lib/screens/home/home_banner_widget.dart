import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/challenge_page.dart';
import 'package:grocery_app/styles/colors.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeChallenge()),
        );
      },
      child: Container(
        width: 500,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: AssetImage("assets/images/banner/banner2button.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),

      // child: Row(
      //   children: [
      //     Container(
      //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //       child: Image.asset(
      //         "assets/images/banner_image.png",
      //       ),
      //     ),
      //     Spacer(),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         AppText(
      //           text: "Fresh Vegetables",
      //           fontSize: 22,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         AppText(
      //           text: "Get Up To 40%  OFF",
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.primaryColor,
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       width: 20,
      //     )
      //   ],
      // ),
    );
  }
}
