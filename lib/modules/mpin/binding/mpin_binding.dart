import 'package:book_management/modules/login/controller/login_controller';
import 'package:get/get.dart';

class MpinBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put the LoginController so it is initialized when needed
    Get.lazyPut<LoginController>(() => LoginController());
  }
}