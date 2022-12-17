class RegisterModel {
  String? email;
  String? password;
  String? username;

  RegisterModel({this.email, this.password, this.username});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    return data;
  }
}
