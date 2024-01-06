import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

String gilroyFontFamily = "Gilroy";

TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: Colors.black,
  ),
);

ThemeData themeData = ThemeData(
  fontFamily: gilroyFontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: AppColors.primaryColor, // Define your primary color here
  backgroundColor: Colors.white, // Set the default background color to white
  scaffoldBackgroundColor:
      Colors.white, // Set Scaffold's default background color to white
  textTheme: TextTheme(
    // Define text themes if needed, for example:
    bodyText1: TextStyle(color: Colors.black), // Default text color
    bodyText2:
        TextStyle(color: Colors.black), // You can adjust based on your needs
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.primaryColor, // Your secondary color
    // Ensure other color properties are set correctly
    background: Colors.white, // Background color for elements like Card
    onBackground:
        Colors.black, // Color for text and icons on top of background color
    // Add other color properties if needed
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white, // Sets the default text/icon color to white
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white, // Sets the default background color of Card to white
    // Add other Card properties if needed
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white, // Sets dialog background color to white
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0), // Optional: Style for dialog title text
    contentTextStyle: TextStyle(
        color: Colors.black, fontSize: 16.0), // Style for dialog content text
  ),
);
