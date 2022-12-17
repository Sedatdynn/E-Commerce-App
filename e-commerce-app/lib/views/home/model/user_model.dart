class GetUserModel {
  String? username;
  String? email;
  List<Basket>? basket;
  String? sId;
  String? salt;
  String? hashedPassword;
  String? updatedAt;
  String? createdAt;

  GetUserModel(
      {this.username,
      this.email,
      this.basket,
      this.sId,
      this.salt,
      this.hashedPassword,
      this.updatedAt,
      this.createdAt});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    if (json['basket'] != null) {
      basket = <Basket>[];
      json['basket'].forEach((v) {
        basket!.add(Basket.fromJson(v));
      });
    }
    sId = json['_id'];
    salt = json['salt'];
    hashedPassword = json['hashed_password'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    if (basket != null) {
      data['basket'] = basket!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['salt'] = salt;
    data['hashed_password'] = hashedPassword;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Basket {
  int? pId;

  Basket({this.pId});

  Basket.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_id'] = pId;
    return data;
  }
}
