import 'package:beginer_bloc/views/home/home_shelf.dart';
import 'package:beginer_bloc/views/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/const/packagesShelf/packages_shelf.dart';

abstract class IGeneralService {
  IGeneralService(
    this.dio,
    this.item,
  );
  final Dio dio;
  String item;

  Future<List<Products>?> fetchProductItems();
  Future<GetUserModel> getUser();
  Future<bool?> postBasket(int pId);
  Future<bool?> deleteBasket(int pId);
}

class GeneralService extends IGeneralService {
  GeneralService(
    super.dio,
    super.item,
  );

  @override
  Future<List<Products>?> fetchProductItems() async {
    print("******************");
    try {
      final response = await dio.get("/api/products/");
      var resData = response.data;
      print("****************");
      if (response.statusCode == HttpStatus.ok) {
        List<Products>? products = ProductModel.fromJson(resData).products;

        return products;
      }
    } catch (e) {
      throw e.toString();
    }

    throw "Something went wrong";
  }

  Future<GetUserModel> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("token");
      final response = await dio.get("/api/user/",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == HttpStatus.ok) {
        final jsonBody = response.data;
        if (jsonBody is Map<String, dynamic>) {
          final tok = GetUserModel.fromJson(jsonBody);

          return tok;
        }
      }
    } catch (e) {
      throw e.toString();
    }
    throw "fdsaadfs";
  }

  Future<bool?> postBasket(
    int pId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("token");
      final response = await dio.post("/api/user/basket/add/",
          data: {"product_id": pId},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> deleteBasket(
    int pId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("token");
      final response = await dio.delete("/api/user/basket/delete/",
          data: {"product_id": pId},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
