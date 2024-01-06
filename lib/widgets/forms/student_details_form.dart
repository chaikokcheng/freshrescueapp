import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/res/custom_colors.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/utils/db_queries.dart';
import 'package:grocery_app/utils/db_validator.dart';
import 'package:grocery_app/widgets/custom_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:grocery_app/utils/custom_drop_down.dart';

class DbAddItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode jntuFocusNode;
  final FocusNode shortIntroFocusNode;
  final FocusNode phoneFocusNode;

  final String userDisplayName;
  final String userEmailID;
  final User user;

  const DbAddItemForm(
      {required this.user,
      required this.userDisplayName,
      required this.userEmailID,
      required this.nameFocusNode,
      required this.emailFocusNode,
      required this.jntuFocusNode,
      required this.shortIntroFocusNode,
      required this.phoneFocusNode});

  @override
  _DbAddItemFormState createState() => _DbAddItemFormState();
}

class _DbAddItemFormState extends State<DbAddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  int _selectedIndex = -1;
  String selectedYearOfStudy = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jntuController = TextEditingController();
  final TextEditingController _shortIntroController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _domainSelectedController =
      TextEditingController();

  String userEmailID = "";
  String userDisplayName = "";
  User? user;

  // // Declaring the list of Domains
  // final List<SelectedListItem> _listOfDomains = [
  //   SelectedListItem(false, "Android"),
  //   SelectedListItem(false, "HTML, CSS and JS"),
  //   SelectedListItem(false, "MERN Stack"),
  //   SelectedListItem(false, "Flutter"),
  //   SelectedListItem(false, "Machine Learning"),
  //   SelectedListItem(false, "Data Science"),
  // ];

  final List<SelectedListItem> _listOfRoles = [
    SelectedListItem(false, "Normal User"),
    SelectedListItem(false, "Farmer"),
    SelectedListItem(false, "Business"),
  ];

  TextEditingController _searchTextEditingController = TextEditingController();

  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: "Done",
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: "Search your role",
        bottomSheetTitle: "List of role",
        searchBackgroundColor: Palette.firebaseYellow,
        dataList: _listOfRoles,
        selectedItems: (List<dynamic> selectedList) {
          showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          //showSnackBar(selected);
          _domainSelectedController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadSharedPrefs();
  }

  /* void _loadSharedPrefs() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() async {
      userEmailID = prefs.getString("userEmail")!;
      userDisplayName = prefs.getString("userDisplayName")!;
    });

   // _nameController.text = userDisplayName;
  }*/

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.userDisplayName;
    user = widget.user;

    return Form(
        key: _addItemFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _nameController,
                      focusNode: widget.nameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => DbValidator.validateField(
                        value: value,
                      ),
                      label: 'Name of Student',
                      hint: 'Enter your Name',
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'City',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _jntuController,
                      focusNode: widget.jntuFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => DbValidator.validateField(
                        value: value,
                      ),
                      label: 'City',
                      hint: 'Your living city',
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'Age group',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    ToggleSwitch(
                      initialLabelIndex:
                          _selectedIndex, // Use the _selectedIndex here
                      totalSwitches: 3,
                      minWidth: 102.0,
                      fontSize: 16.0,
                      minHeight: 55.0,
                      activeBgColor: [AppColors.primaryColor],
                      inactiveBgColor:
                          Colors.grey, // Set an inactive color if needed
                      labels: ["Below 20", "20 to 40", "Above 40"],
                      onToggle: (index) {
                        setState(() {
                          // Call setState to update the UI
                          _selectedIndex = index!;
                        });
                        print('Switched to $_selectedIndex');
                      },
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _phoneNumberController,
                      focusNode: widget.phoneFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => DbValidator.validateField(
                        value: value,
                      ),
                      label: 'Enter your Phone Number',
                      hint: 'Enter your Phone Number',
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'You are a',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    /*InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        onTextFieldTap();
                      },
                      child: CustomFormField(
                        isLabelEnabled: false,
                        controller: _domainSelectedController,
                        focusNode: widget.emailFocusNode, // temporarily written
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validator: (value) => DbValidator.validateField(
                          value: value,
                        ),
                        label: 'Choose your Major Domain',
                        hint:
                        'Select your Major Domain',
                      ),
                    )*/
                    TextFormField(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        onTextFieldTap();
                      },
                      controller: _domainSelectedController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: null,
                        labelStyle: TextStyle(color: Palette.firebaseYellow),
                        hintText: "Select the one best describe you",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Palette.firebaseAmber,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'About you',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      maxLines: 10,
                      isLabelEnabled: false,
                      controller: _shortIntroController,
                      focusNode: widget.shortIntroFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      validator: (value) => DbValidator.validateField(
                        value: value,
                      ),
                      label: 'Introduce Yourself',
                      hint:
                          'Introduce about yourself which helps others to know more about you',
                    ),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    )
                  : Container(
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
                          widget.nameFocusNode.unfocus();
                          widget.emailFocusNode.unfocus();
                          widget.jntuFocusNode.unfocus();
                          widget.phoneFocusNode.unfocus();
                          widget.shortIntroFocusNode.unfocus();

                          if (_selectedIndex == -1) {
                            final snackBar = SnackBar(
                              content: Text('Please choose your age group'),
                              backgroundColor: Colors.black,
                              action: null,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          if (_domainSelectedController.text == "") {
                            final snackBar = SnackBar(
                              content: Text(
                                  'Choose Normal User / Farmer / Business'),
                              backgroundColor: Colors.black,
                              action: null,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          if (_addItemFormKey.currentState!.validate() &&
                              _selectedIndex != -1 &&
                              _domainSelectedController.text != "") {
                            setState(() {
                              _isProcessing = true;
                            });

                            // Retrieving the selected Year based on the index
                            if (_selectedIndex == 0)
                              selectedYearOfStudy = "Below 20";
                            else if (_selectedIndex == 1)
                              selectedYearOfStudy = "20 to 40";
                            else
                              selectedYearOfStudy = "Above 40";

                            await Database.addItem(
                                name: _nameController.text,
                                emailID: widget.userEmailID,
                                jntuNo: _jntuController.text,
                                phoneNumber: _phoneNumberController.text,
                                shortIntro: _shortIntroController.text,
                                yearOfStudy: selectedYearOfStudy,
                                majorDomain: _domainSelectedController.text);

                            setState(() {
                              _isProcessing = false;
                            });

                            // initialising Shared Preferences
                            final prefs = await SharedPreferences.getInstance();

                            // setting user Registered
                            await prefs.setBool("userRegisteredStatus", true);

                            // Need to add the student to the respective domain list

                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => DashboardScreen(
                                        // user: widget.user,
                                        // userEmailID: userEmailID,
                                        // userDisplayName:
                                        // _nameController.text.toString(),
                                        )));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
