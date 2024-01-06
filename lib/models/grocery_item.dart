class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String imagePath;

  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Organic Bananas",
      description: "7pcs, Muthu's Farm",
      price: 2.99,
      imagePath: "assets/images/grocery_images/banana.png"),
  GroceryItem(
      id: 2,
      name: "Red Apple",
      description: "2pcs, Goh's Farm",
      price: 2.99,
      imagePath: "assets/images/grocery_images/apple.png"),
  GroceryItem(
      id: 3,
      name: "Brocolli",
      description: "1pcs, Farm Fresh",
      price: 1.99,
      imagePath: "assets/images/grocery_images/broccoli.png"),
  GroceryItem(
      id: 4,
      name: "Chinese Cabbage",
      description: "500gm, Mama Farm",
      price: 1.00,
      imagePath: "assets/images/grocery_images/cabbage.png"),
  GroceryItem(
      id: 5,
      name: "Orange",
      description: "2pcs, Moo Farm",
      price: 2.00,
      imagePath: "assets/images/grocery_images/orange.png"),
  GroceryItem(
      id: 6,
      name: "Tamoto",
      description: "250gm, Moo Farm",
      price: 1.00,
      imagePath: "assets/images/grocery_images/tomato.png"),
];

var exclusiveOffers = [demoItems[0], demoItems[1]];

var bestSelling = [demoItems[2], demoItems[3]];

var groceries = [demoItems[4], demoItems[5]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Dite Coke",
      description: "355ml, Price",
      price: 1.20,
      imagePath: "assets/images/beverages_images/diet_coke.png"),
  GroceryItem(
      id: 8,
      name: "Sprite Can",
      description: "325ml, Price",
      price: 1.20,
      imagePath: "assets/images/beverages_images/sprite.png"),
  GroceryItem(
      id: 8,
      name: "Apple Juice",
      description: "2L, Price",
      price: 5.20,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png"),
  GroceryItem(
      id: 9,
      name: "Orange Juice",
      description: "2L, Price",
      price: 5.50,
      imagePath: "assets/images/beverages_images/orange_juice.png"),
  GroceryItem(
      id: 10,
      name: "Coca Cola Can",
      description: "325ml, Price",
      price: 1.20,
      imagePath: "assets/images/beverages_images/coca_cola.png"),
  GroceryItem(
      id: 11,
      name: "Pepsi Can",
      description: "330ml, Price",
      price: 1.20,
      imagePath: "assets/images/beverages_images/pepsi.png"),
];
