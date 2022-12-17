import 'package:beginer_bloc/views/home/home_shelf.dart';
import '../../../core/const/packagesShelf/packages_shelf.dart';

abstract class IGeneralService {
  IGeneralService(
    this.dio,
    this.item,
  );
  final Dio dio;
  String item;

  Future<List<Products>?> fetchProductItems();
}

class GeneralService extends IGeneralService {
  GeneralService(
    super.dio,
    super.item,
  );

  @override
  Future<List<Products>?> fetchProductItems() async {
    try {
      final response = await dio.get("/api/products/");
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
}
