import 'package:book_management/modules/dashboard/view/dashboard.dart';
import 'package:book_management/modules/login/controller/login_controller.dart';
import 'package:book_management/modules/login/view/login_view.dart';
import 'package:book_management/modules/splashScreen/views/splash_view.dart';
import 'package:book_management/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Inject your controller before running the app
  Get.put(LoginController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo 2',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.routes
    );
  }
}
