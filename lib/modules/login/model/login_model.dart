// user_model.dart
class UserModel {
  final String fullName;
  final String email;
  final String mobileNumber;

  UserModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'].toString(),
    );
  }
}
