import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to dispose'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/pages/disposeedupage.png',
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

  _showEnrollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Uploaded'),
          content: Text('You had done uploaded'),
          actions: [
            TextButton(
              child: Text(
                'Done',
                selectionColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the home screen
              },
            ),
          ],
        );
      },
    );
  }
}
