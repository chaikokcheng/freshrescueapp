import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/order_accepted_screen.dart';
import 'package:grocery_app/screens/product_details/favourite_toggle_icon_widget.dart';
import 'package:grocery_app/widgets/item_counter_widget.dart';

class SurpriseBagScreen extends StatefulWidget {
  @override
  _SurpriseBagScreenState createState() => _SurpriseBagScreenState();
}

class _SurpriseBagScreenState extends State<SurpriseBagScreen> {
  int amount = 1;

  // Dummy data for the GroceryItem
  final bagItem = BagItem(
    name: 'Surprise Bag',
    description: 'YJ FreshMart',
    imagePath:
        'assets/images/yjfreshmart.png', // Make sure this asset exists in your project
    price: 9.99, // Static price
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getImageHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        bagItem.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        bagItem.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C7C7C),
                        ),
                      ),
                      trailing: FavoriteToggleIcon(),
                    ),

                    Divider(thickness: 1),
                    getProductDataRowWidget(
                      "Shop Review",
                      customWidget: ratingWidget(),
                    ),

                    Divider(thickness: 1),

                    getProductDataRowWidget("Product Details:"),
                    Text(
                      "Expect a delightful surprise with each bag you receive! Your selection may include a variety of fresh and nutritious items such as: \nCarrots, \nApples, \nCabbage, \nTomato, \nPeppers, \nGarlic, \nSalad \n... and much more",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // This makes the text bold
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),

                    // Divider(thickness: 1),
                    // getProductDataRowWidget("Nutritions",
                    //     customWidget: nutritionWidget()),

                    Spacer(),
                    Row(
                      children: [
                        ItemCounterWidget(
                          onAmountChanged: (newAmount) {
                            setState(() {
                              amount = newAmount;
                            });
                          },
                        ),
                        Spacer(),
                        Text(
                          "\RM${getTotalPrice().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),

                    AppButton(
                      label: "Place Order",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderAcceptedScreen()),
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addToBasket() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Item Added"),
          content: Text("Surprise bag has been added to your cart."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250, // Adjust the height as needed
      width: double.infinity, // This ensures the container takes full width
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
            colors: [
              Color(0xFF3366FF).withOpacity(0.1),
              Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Image(
        image: AssetImage(bagItem.imagePath),
        fit: BoxFit.cover, // This will cover the entire width of its parent
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          // Icon(
          //   Icons.arrow_forward_ios,
          //   size: 20,
          // )
        ],
      ),
    );
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "100gm",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    return amount * bagItem.price;
  }
}

class BagItem {
  final String name;
  final String description;
  final String imagePath;
  final double price;

  BagItem({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}
