
import 'package:detect_mask_v2/src/page/HomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var d = const Duration(seconds: 5);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/mask.png")
            )
          ),
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              title: Text("Medical App",
              textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(55),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CircularProgressIndicator(
            color: Colors.indigo,
          ),
        ),
        )
      ],)
    );
  }
}
