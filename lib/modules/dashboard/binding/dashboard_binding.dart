import 'package:book_management/modules/dashboard/controller/category_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(CategoryController());

  }

}