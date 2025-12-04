import 'package:book_management/modules/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    loginController.loadIsDataStored();

    Future.delayed(Duration(seconds: 2), () {
      if (loginController.isDataStored.value) {
        Get.offNamed('/home'); // or '/mpin' if that’s your logic
      } else {
        Get.offNamed('/login');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Netflix background color
      body: Center(
        child: Text(
          "N",
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ).animate().fadeIn(duration: Duration(seconds: 1)).scaleXY(begin: 0.5, end: 1.2, duration: Duration(seconds: 2)),
      ),
    );
  }
}
