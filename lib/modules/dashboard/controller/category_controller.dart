import 'dart:convert';

import 'package:book_management/modules/dashboard/models/book_model.dart';
import 'package:book_management/modules/dashboard/models/category_model.dart';
import 'package:book_management/repository/api_client.dart';
import 'package:book_management/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/api_endpoints.dart';

class CategoryController extends GetxController {

  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var bookList = <BookModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;

    // Debugging Logs
    try {
      final response = await ApiHelper.get(ApiEndpoints.getCategoryList);

      debugPrint(response.toString()); // <-- FIXED (response is a Map)
      if(response['status'] == 'S'){

      final List<dynamic> data = response['data']; // <-- FIXED

      categories.value = data.map((json) => Category.fromJson(json)).toList();
      update();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (error) {
      debugPrint('Error:${error.toString()}');


    } finally {
      isLoading.value = false;
    }
  }

}