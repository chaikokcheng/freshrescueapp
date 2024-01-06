import 'package:flutter/material.dart';
import 'package:grocery_app/screens/challenge_page.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/donation_page.dart';
import 'package:grocery_app/screens/surprise_bag_screen.dart';

class CarouselBanner extends StatefulWidget {
  CarouselBanner({Key? key}) : super(key: key);

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  final PageController _controller = PageController();

  // Define a list of routes or functions for each image

  // Update this list to contain asset paths for your local images
  List<String> imgCarousel = [
    'assets/images/banner/banner1.png',
    'assets/images/banner/banner2.png',
    'assets/images/banner/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateState());
  }

  void _animateState() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (_controller.hasClients) {
        int nextPage = _controller.page!.round() + 1;
        if (nextPage >= imgCarousel.length) {
          nextPage = 0;
        }
        _controller
            .animateToPage(nextPage,
                duration: Duration(seconds: 1), curve: Curves.linear)
            .then((_) => _animateState());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Function> _navigationActions = [
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SurpriseBagScreen())),
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => RecipeChallenge())),
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => DonationScreen())),
    ];

    void _handleImageTap(int index) {
      // Call the corresponding function based on the image index
      if (index < _navigationActions.length) {
        _navigationActions[index]();
      }
    }

    return Container(
      height: size.height * .22,
      child: PageView.builder(
        controller: _controller,
        pageSnapping: true,
        itemCount: imgCarousel.length,
        itemBuilder: (context, pagePositioned) {
          return InkWell(
            onTap: () => _handleImageTap(pagePositioned),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    15.0), // Adjust the radius here for more or less roundness
                child: Image.asset(
                  imgCarousel[pagePositioned],
                  fit: BoxFit.cover, // Keeps the image to fill the area
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
