import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/tflite/services/navigation_service.dart';
import 'package:grocery_app/tflite/services/tensorflow_service.dart';
import 'package:grocery_app/tflite/app_router.dart';
import 'package:grocery_app/tflite/view_models/home_view_model.dart';
import 'package:grocery_app/styles/theme.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Gemini.init(
      apiKey: 'AIzaSyBNNy1Kz7MvIeqaCwCfHQFEISKp1cXFr6Q', enableDebugging: true);
  runApp(MultiProvider(
    providers: [
      Provider<NavigationService>(create: (_) => NavigationService()),
      Provider<TensorFlowService>(create: (_) => TensorFlowService()),
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(
            context, Provider.of<TensorFlowService>(context, listen: false)),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
          theme: themeData,
          navigatorKey: NavigationService.navigationKey,
        );
      },
    );
  }
}
