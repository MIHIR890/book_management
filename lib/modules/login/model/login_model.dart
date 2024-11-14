// user_model.dart

class LoginModel {
  final String fullName;
  final String email;
  final String mobileNumber;

  LoginModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      fullName: json['fullName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'].toString(),
    );
  }
}
