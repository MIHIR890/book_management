import 'package:book_management/modules/login/controller/login_controller.dart';
import 'package:book_management/modules/login/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isTapped = false;
  double _animatedWidth = 0;
  LoginController loginController = Get.find<LoginController>();

  void _onTap() {
    setState(() {
      isTapped = !isTapped;
      _animatedWidth = isTapped ? 177 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          GestureDetector(
            onTap: (){
              loginController.logOut(context);
            },
              child: Icon(Icons.logout))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(
                  'https://www.example.com/path/to/profile/image.jpg'), // Replace with actual image URL or use AssetImage for local images
              child: Icon(Icons.person, size: 50), // Fallback icon
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () => {},
              child: Container(
                height: 50,
                width: 163,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text("Add Profile Picture",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.abc),
                          label: Text(loginController.userModel?.email ?? "")),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email:',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.email),
                          label: Text(loginController.userModel?.fullName ?? "")),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile Number:',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.phone),
                          label: Text(loginController.userModel?.mobileNumber ?? "")),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  height: 52,
                  width: 177,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 52,
                  width: _animatedWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: _onTap,
                  child: SizedBox(
                    height: 52,
                    width: 177,
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
