
import 'package:detect_mask_v2/src/page/HomeScreen.dart';
import 'package:detect_mask_v2/src/page/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List <CameraDescription> camera=[];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var camera = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash",
      routes: {
        "splash": (context) => SplashScreen(),
        "home": (context) => HomeScreen(),
      },
    );
  }
}
