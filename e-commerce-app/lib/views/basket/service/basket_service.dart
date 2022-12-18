import 'package:beginer_bloc/views/home/home_shelf.dart';
import 'package:beginer_bloc/views/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/const/packagesShelf/packages_shelf.dart';

abstract class IGeneralBasketService {
  IGeneralBasketService(
    this.dio,
  );
  final Dio dio;

  Future<List<Products>?> fetchProductItems();
  Future<bool?> deleteBasket(int pId);
}

class GeneralBasketService extends IGeneralBasketService {
  GeneralBasketService(
    super.dio,
  );

  @override
  Future<List<Products>?> fetchProductItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("token");
      final response = await dio.get("/api/user/basket/",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      var resData = response.data;
      if (response.statusCode == HttpStatus.ok) {
        List<Products>? products = ProductModel.fromJson(resData).products;
        return products;
      }
    } catch (e) {
      throw e.toString();
    }

    throw "Something went wrong";
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
