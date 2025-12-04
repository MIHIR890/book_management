import 'package:book_management/modules/audioBook/binding/audio_binding.dart';
import 'package:book_management/modules/audioBook/view/audioBook_view.dart';
import 'package:book_management/modules/dashboard/binding/dashboard_binding.dart';
import 'package:book_management/modules/dashboard/view/dashboard.dart';
import 'package:book_management/modules/login/binding/login_binding.dart';
import 'package:book_management/modules/login/view/login_view.dart';
import 'package:book_management/modules/mpin/binding/mpin_binding.dart';
import 'package:book_management/modules/mpin/view/mpin_view.dart';
import 'package:book_management/modules/splashScreen/views/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const INITIAL2 = Routes.MPIN;

  static final routes = [
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => const DashboardDrawerWrapper(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MPIN,
      page: () => const MpinView(),
      binding: MpinBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () =>  SplashScreen(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () =>  Dashboard(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: _Paths.AUDIOBOOK,
      page: () =>  AudiobookView(),
      binding: AudioBinding()
    ),
   
  ];
}