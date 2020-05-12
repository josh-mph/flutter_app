import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginModel{
  String username;
  String password;

  LoginModel();

  @override
  String toString() {
    return "{\"username\" : \""+this.username+"\", \"password\" : \""+this.password+"\"}";
  }

}

@JsonSerializable()
class RegistrationClass{
  String firstName;
  String lastName;
  String cellNumber;
  String email;
  String password;

  @override
  String toString() {
    return "{\"FullName\" : \""+this.firstName+" "+this.lastName+"\",\"CellNumber\" : \""+this.cellNumber+"\",\"Email\" : \""+this.email+"\",\"Password\" : \""+this.password+"\"}";
  }

}

class LoginResponse {
  String userId;
  int success;
  String message;
  String fullName;
  String email;
  String cellNumber;
  String profileUrl;
  String token;

  LoginResponse({this.userId, this.success, this.message, this.fullName, this.email, this.cellNumber, this.profileUrl, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['UserId'],
      success: json['Success'],
      message: json['Message'],
      fullName: json['FullName'],
      email: json['Email'],
      cellNumber: json['CellNumber'],
      profileUrl: json['ProfileUrl'],
      token: json['Token'],
    );
  }
}