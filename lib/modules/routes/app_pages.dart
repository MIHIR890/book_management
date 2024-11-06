import 'package:book_management/modules/login/binding/login_binding.dart';
import 'package:book_management/modules/login/view/login_view.dart';
import 'package:book_management/modules/mpin/binding/mpin_binding.dart';
import 'package:book_management/modules/mpin/view/mpin_view.dart';
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
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MPIN,
      page: () => MpinView(),
      binding: MpinBinding(),
    ),
   
  ];
}