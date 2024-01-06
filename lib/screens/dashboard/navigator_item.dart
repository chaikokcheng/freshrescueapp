import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/challenge_page.dart';
import 'package:grocery_app/screens/donation_page.dart';
import 'package:grocery_app/screens/explore_screen.dart';
import 'package:grocery_app/screens/home/home_screen.dart';
import 'package:grocery_app/screens/inventory_page.dart';
import '../favourite_screen.dart';

List<InventoryItem> globalInventoryList = [];
void Function(InventoryItem) globalAddToInventory = (InventoryItem item) {
  globalInventoryList.add(item);
  // Trigger a rebuild if necessary
};

void Function(InventoryItem) globalRemoveFromInventory = (InventoryItem item) {
  globalInventoryList.remove(item);
  // Trigger a rebuild if necessary
};

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", "assets/icons/shop_icon.svg", 0, HomeScreen()),
  NavigatorItem(
      "Challenge", "assets/icons/challenge.svg", 1, CommunityScreen()),
  NavigatorItem(
      "Donation", "assets/icons/donation_icon.svg", 2, DonationScreen()),
  NavigatorItem(
      "Inventory",
      "assets/icons/parcel.svg",
      3,
      InventoryPage(
        inventoryItems: globalInventoryList,
        removeFromInventory: globalRemoveFromInventory,
      )),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 4, AccountScreen()),
];
