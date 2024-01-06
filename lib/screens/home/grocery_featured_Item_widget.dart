import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/styles/colors.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;

  GroceryFeaturedItem(this.name, this.imagePath);
}

var groceryFeaturedItems = [
  GroceryFeaturedItem(
      "Surprise \nBag", "assets/images/grocery_images/surprisebag.png"),
  GroceryFeaturedItem(
      "Fruit & Vegetables", "assets/images/grocery_images/fruitbag.png"),
  GroceryFeaturedItem(
      "Other Categories", "assets/images/grocery_images/staplesbag.png"),
];

class GroceryFeaturedCard extends StatelessWidget {
  const GroceryFeaturedCard(this.groceryFeaturedItem,
      {this.color = AppColors.primaryColor});

  final GroceryFeaturedItem groceryFeaturedItem;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Decreased width for a standing rectangle
      height: 250, // Increased height for a standing rectangle
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                18), // Clip the image to the border radius
            child: Image(
              image: AssetImage(groceryFeaturedItem.imagePath),
              width: 100, // Adjust the width of the image to prevent overflow
              height: 80, // Adjust the height of the image to prevent overflow
              fit: BoxFit
                  .cover, // Ensure the aspect ratio of the image is preserved
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppText(
            text: groceryFeaturedItem.name,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
