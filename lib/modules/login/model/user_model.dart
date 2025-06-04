// user_model.dart

class UserModel {
  final String? fullName;
  final String? email;
  final String? mobileNumber;

  UserModel({
    this.fullName,
    this.email,
    this.mobileNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    return data;
  }

}
