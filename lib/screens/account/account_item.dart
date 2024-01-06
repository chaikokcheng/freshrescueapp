class AccountItem {
  final String label;
  final String iconPath;

  AccountItem(this.label, this.iconPath);
}

List<AccountItem> accountItems = [
  AccountItem("Add Product", "assets/icons/account_icons/orders_icon.svg"),
  AccountItem("My Cart", "assets/icons/account_icons/cart_icon.svg"),
  AccountItem(
      "Delivery Access", "assets/icons/account_icons/delivery_icon.svg"),
  AccountItem("Payment Methods", "assets/icons/account_icons/payment_icon.svg"),
  AccountItem(
      "Rewards Store", "assets/icons/account_icons/workspace_premium.svg"),
  AccountItem(
      "Notifications", "assets/icons/account_icons/notification_icon.svg"),
  AccountItem("Help", "assets/icons/account_icons/help_icon.svg"),
  AccountItem("About", "assets/icons/account_icons/about_icon.svg"),
];
