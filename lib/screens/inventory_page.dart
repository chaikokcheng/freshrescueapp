import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grocery_app/screens/dashboard/navigator_item.dart';
import 'package:grocery_app/screens/education_page.dart';
import 'package:grocery_app/screens/gemini/geminiapp.dart';

import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/tflite/pages/arscan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class InventoryItem {
  String productName;
  DateTime expirationDate;
  String imageUrl;
  bool isSelected; // New property

  InventoryItem({
    required this.productName,
    required this.expirationDate,
    required this.imageUrl,
    this.isSelected = false, // Default value

    // Add toJson and fromJson method
  });

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'expirationDate': expirationDate.toIso8601String(),
        'imageUrl': imageUrl,
      };

  static InventoryItem fromJson(Map<String, dynamic> json) => InventoryItem(
        productName: json['productName'],
        expirationDate: DateTime.parse(json['expirationDate']),
        imageUrl: json['imageUrl'],
      );

  // Add encode and decode methods
  static String encode(List<InventoryItem> items) => json.encode(
        items.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
      );

  static List<InventoryItem> decode(String items) =>
      (json.decode(items) as List<dynamic>)
          .map<InventoryItem>((item) => InventoryItem.fromJson(item))
          .toList();
}

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
  final List<InventoryItem> inventoryItems;
  final Function(InventoryItem) removeFromInventory;

  InventoryPage(
      {required this.inventoryItems, required this.removeFromInventory});
}

class _InventoryPageState extends State<InventoryPage> {
  List<InventoryItem> inventoryItems = [
    InventoryItem(
      productName: 'Banana',
      expirationDate: DateTime.now().add(Duration(days: -1)),
      imageUrl:
          'https://fruitboxco.com/cdn/shop/products/asset_2_grande.jpg?v=1571839043',
    ),
    InventoryItem(
      productName: 'Apple',
      expirationDate: DateTime.now().add(Duration(days: 2)),
      imageUrl:
          'https://images.pexels.com/photos/206959/pexels-photo-206959.jpeg?cs=srgb&dl=pexels-pixabay-206959.jpg&fm=jpg',
    ),
    InventoryItem(
      productName: 'Spinach',
      expirationDate: DateTime.now().add(Duration(days: 5)),
      imageUrl: 'https://pngimg.com/d/spinach_PNG33.png',
    ),
    InventoryItem(
      productName: 'Cheese',
      expirationDate: DateTime.now().add(Duration(days: 15)),
      imageUrl:
          'https://img.freepik.com/free-photo/delicious-piece-cheese_144627-43344.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1698883200&semt=ais',
    ),
  ];

  Widget _buildImageWidget(String imageUrl) {
    // Check if the imageUrl is a local file path
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // It's a network image
      return Image.network(
        imageUrl,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text('Failed to load image');
        },
      );
    } else {
      // It's a local image
      return Image.file(
        File(imageUrl),
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      );
    }
  }

  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isCameraPreviewShown = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    loadInventory();
    initCamera(); // Initialize the camera
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();

    setState(() {});
  }

  Widget cameraPreviewWidget() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Text('Loading Camera...');
    }
    return CameraPreview(_cameraController!); // Display the camera preview
  }

  Future<XFile?> takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      print('Error: Camera not initialized');
      return null;
    }

    try {
      final image = await _cameraController!.takePicture();
      return image;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> sendImageToGeminiApp(XFile imageFile) async {
    // Convert the image file to a byte array
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Prepare the prompt
    String prompt =
        "Generate Recipe based on the ingredients in the picture, provide [Dish Name],[Ingredients],[Instructions],then blank 3 row";

    // Use the Gemini instance to send the image and prompt
    final gemini = Gemini.instance;

    String recipeOutput = '';
    int recipeCount = 0; // Counter to track the number of recipes generated

    // Initialize and show the dialog once
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        StreamSubscription?
            streamSubscription; // Declare the StreamSubscription as nullable

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Start listening to the stream inside the dialog
            streamSubscription = gemini
                .streamGenerateContent(prompt, images: [imageBytes]).listen(
              (response) {
                // Update the dialog content using setState
                setState(() {
                  // Append the new output to the existing recipe output
                  recipeOutput += response.output ?? '';
                  recipeCount++;
                });

                if (recipeCount >= 3) {
                  // Cancel the stream subscription after three recipes are generated
                  streamSubscription?.cancel();
                }
              },
              onDone: () {
                // Optionally update the state to reflect that loading is complete
                setState(() {});
              },
              onError: (error) {
                // Optionally handle errors, such as updating the state with an error message
                print("Error while processing image: $error");
              },
            );

            return AlertDialog(
              title: const Text('AI Generated Recipe'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.file(File(imageFile.path),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover), // Display the captured image
                    Text(recipeOutput.isEmpty
                        ? 'Generating recipes...'
                        : recipeOutput),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    streamSubscription
                        ?.cancel(); // Cancel the stream when the dialog is closed
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showConfirmationDialog(XFile imageFile) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.file(File(imageFile.path)), // Display the captured image
                const Text(
                    'Would you like to use this picture to generate a recipe?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                sendImageToGeminiApp(
                    imageFile); // Proceed to send the image to Gemini
              },
            ),
          ],
        );
      },
    );
  }

  void addToInventory(InventoryItem item) {
    setState(() {
      inventoryItems.add(item); // Add the item to the inventory list
      saveInventory(); // Save the updated inventory list to persistent storage
    });
  }

  void startBarcodeScan() async {
    String barcode = await BarcodeUtils.scanBarcode();
    await BarcodeScanHelper.fetchAndDisplayProduct(
        context, barcode, addToInventory);
  }

  void showAddItemDialog() {
    String productName = '';
    DateTime? expirationDate;
    XFile? imageFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update the dialog content
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Item'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        productName = value;
                      },
                      decoration: InputDecoration(hintText: "Product Name"),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text(imageFile == null
                          ? 'Tap to take a picture'
                          : 'Picture taken!'),
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Capture a photo
                        final XFile? photo =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          setState(() {
                            // Update the state of the dialog to show the new image
                            imageFile = photo;
                          });
                        }
                      },
                    ),
                    if (imageFile !=
                        null) // Only display the image if it is not null
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(imageFile!.path),
                          height: 100, // Set a fixed height to prevent overflow
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ListTile(
                      title: Text(expirationDate == null
                          ? 'Tap to select expiration date'
                          : 'Expiration date: ${expirationDate!.toLocal()}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: expirationDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != expirationDate) {
                          setState(() {
                            // Update the state of the dialog to show the new date
                            expirationDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    if (productName.isNotEmpty &&
                        expirationDate != null &&
                        imageFile != null) {
                      // Check if imageFile is not null
                      final newItem = InventoryItem(
                        productName: productName,
                        expirationDate: expirationDate!,
                        imageUrl:
                            imageFile!.path, // Use the path of the image file
                      );
                      addToInventory(newItem); // Use the addToInventory method
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // void initState() {
  //   super.initState();
  //   loadInventory();
  //   // Generate mockup data
  //   // generateMockupData();
  // }

  void loadInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? inventoryJson = prefs.getString('inventory');
    if (inventoryJson != null) {
      setState(() {
        inventoryItems = InventoryItem.decode(inventoryJson);
      });
    }
  }

  void saveInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final String inventoryJson = InventoryItem.encode(inventoryItems);
    await prefs.setString('inventory', inventoryJson);
  }

  void removeFromInventory(InventoryItem item) {
    setState(() {
      inventoryItems.remove(item);
      saveInventory();
    });
  }

  void toggleSelection(InventoryItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  }

  String recipeText = '';

  Future<void> generateRecipes() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generate Recipe'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Text('Based on Selection'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    generateRecipesBasedOnSelection(); // Call the original recipe generation method
                  },
                ),
                TextButton(
                  child: Text('Take Picture'),
                  onPressed: () async {
                    XFile? imageFile = await takePicture();
                    if (imageFile != null) {
                      await showConfirmationDialog(imageFile);
                    } else {
                      // Handle the case when image capture is unsuccessful or cancelled
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()), //GEMINI PAGE
                    );
                  },
                  child: Text('AI Chatbot'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> generateRecipesBasedOnSelection() async {
    List<String> selectedProductNames = inventoryItems
        .where((item) => item.isSelected)
        .map((item) => item.productName)
        .toList();

    // Convert the list of selected product names into a natural language string
    String ingredientList = selectedProductNames.join(', ');

    // The endpoint for the ChatGPT API
    String chatGptApiEndpoint = 'https://api.openai.com/v1/completions';

    try {
      showDialog(
        context: context,
        barrierDismissible: false, // User must tap button to dismiss
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("Generating recipes..."),
                ],
              ),
            ),
          );
        },
      );
      // Make a POST request to the ChatGPT API
      http.Response response = await http.post(
        Uri.parse(chatGptApiEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer sk-lFUziyTqfZ9kF5x9U094T3BlbkFJCnqQd4VXgMaVxvNESL//4S', // Replace with your actual API key
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt":
              "Create a recipe from ingredients: \n$ingredientList , asia or western food is preferred'",
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        // Parse the response body
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String recipe = responseBody['choices'][0]
            ['text']; // Adjust based on the actual response structure

        // Show the recipe in a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('FreshRescue AI Recipe'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(recipe,
                        style: TextStyle(height: 1.5)), // Improved line spacing
                    // Add more styling and elements as needed here
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Copy Recipe'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: recipe));
                  },
                ),
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context);
        // Handle the case where the server returns a non-200 HTTP status code
        print('Failed to generate recipe. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.pop(context);
      // Handle any errors that occur during the HTTP request
      print('Failed to generate recipe. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort items by expiration date
    inventoryItems.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));

    // Categorize items
    Map<String, List<InventoryItem>> categorizedItems = {
      'Expired': [],
      'Nearly Expired': [],
      'Expired This Week': [],
      'More Than 7 Days': [],
    };

    final now = DateTime.now();
    for (var item in inventoryItems) {
      final daysUntilExpiration = item.expirationDate.difference(now).inDays;
      if (daysUntilExpiration < 0) {
        categorizedItems['Expired']!.add(item);
      } else if (daysUntilExpiration <= 3) {
        categorizedItems['Nearly Expired']!.add(item);
      } else if (daysUntilExpiration <= 7) {
        categorizedItems['Expired This Week']!.add(item);
      } else {
        categorizedItems['More Than 7 Days']!.add(item);
      }
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16), // Add horizontal padding for alignment
            child: Text(
              "Inventory",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center the text if you want
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              // Navigate to other page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationPage()),
              );
            },
            child: Container(
              width: double.infinity, // full width
              padding: EdgeInsets.all(16.0), // padding value
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(8.0), // rounded corner radius
                child: Image.asset(
                  'assets/images/pages/edubanner.png', // replace with your image asset path
                  fit: BoxFit.cover, // this will cover the container's bounds
                ),
              ),
            ),
          ),
          ...categorizedItems.entries.map((entry) {
            return ExpansionTile(
              initiallyExpanded: true, // Auto-expand categories
              title: Text(
                entry.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: entry.key == 'Expired' ? Colors.red : Colors.black,
                ),
              ),
              children: entry.value.map((item) {
                return Card(
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: item.isSelected,
                          onChanged: (bool? newValue) {
                            if (newValue != null) {
                              toggleSelection(item);
                            }
                          },
                        ),
                        _buildImageWidget(item.imageUrl), // Use the new method
                      ],
                    ),
                    title: Text(item.productName),
                    subtitle: Text(
                        'Expires on: ${DateFormat('yyyy-MM-dd').format(item.expirationDate.toLocal())}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeFromInventory(item);
                      },
                    ),
                    onTap: () {
                      toggleSelection(item);
                    },
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16), // Add padding to the left and right
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // This makes the column only as tall as its children
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: generateRecipes,
                    icon: Icon(Icons.receipt),
                    label: Text('Generate Recipe'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      visualDensity: VisualDensity
                          .compact, // Add horizontal padding// Set the height to 50
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      primary: AppColors.primaryColor, // Green background color
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: showAddItemDialog,
                    icon: Icon(Icons.add),
                    label: Text('Add Item'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 50), // Set the height to 50
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      visualDensity:
                          VisualDensity.compact, // Add horizontal padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),

                      primary: AppColors.primaryColor, // Green background color
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: startBarcodeScan,
                    icon: Icon(Icons.qr_code_2),
                    label: Text('Barcode Scan'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 50), // Set the height to 50
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      primary: AppColors.primaryColor, // Green background color
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add space between the buttons
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Use Navigator to push ARScanPage onto the stack
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ARscan()),
                      );
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('AR Scan'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 50), // Set the height to 50
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      primary: AppColors.primaryColor, // Green background color
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BarcodeUtils {
  static Future<String> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );
    return barcodeScanRes;
  }
}

class BarcodeScanHelper {
  static Future<void> fetchAndDisplayProduct(BuildContext context,
      String barcode, Function(InventoryItem) addToInventory) async {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Scanning..."),
              ],
            ),
          ),
        );
      },
    );
    if (barcode == '-1') {
      Navigator.pop(context);
      return;
    }

    final String url =
        'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final productData = jsonDecode(response.body);
      if (productData['status'] == 1) {
        Navigator.pop(context);
        showProductDialog(context, productData['product'], addToInventory);
      } else {
        Navigator.pop(context);
        // Handle the case where the product is not found
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Product not found'),
            content: Text('No product details available for this barcode.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } else {
      Navigator.pop(context);
      // Handle network error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch product details.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  static void showProductDialog(BuildContext context,
      Map<String, dynamic> product, Function(InventoryItem) addToInventory) {
    DateTime? expirationDate;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: expirationDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != expirationDate) {
        expirationDate = picked;
      }
    }

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(product['product_name'] ?? 'Unknown Product'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.network(
                    product['image_url'] ?? 'https://via.placeholder.com/150',
                    height: 150,
                    width: 150,
                  ),
                  Text('Brands: ${product['brands_tags'] ?? 'N/A'}'),
                  Text('Quantity: ${product['quantity'] ?? 'N/A'}'),
                  ListTile(
                    title: Text(expirationDate == null
                        ? 'Tap to select expiration date'
                        : 'Expiration date: ${expirationDate!.toLocal()}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      await _selectDate(context);
                      setState(() {}); // Update the UI with the new date
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Add to Inventory'),
                onPressed: () {
                  if (expirationDate == null) {
                    _selectDate(
                        context); // Prompt the user to pick a date if they haven't already
                  } else {
                    // Create the inventory item and add it to the inventory
                    final inventoryItem = InventoryItem(
                      productName: product['product_name'] ?? 'Unknown Product',
                      expirationDate: expirationDate!,
                      imageUrl: product['image_url'] ??
                          'https://via.placeholder.com/150',
                    );
                    addToInventory(
                        inventoryItem); // Use the addToInventory callback
                    Navigator.of(context).pop(); // Close the dialog
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
