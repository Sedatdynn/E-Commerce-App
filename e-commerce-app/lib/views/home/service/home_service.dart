import 'package:beginer_bloc/views/home/home_shelf.dart';
import '../../../core/const/packagesShelf/packages_shelf.dart';

abstract class IGeneralService {
  IGeneralService(
    this.dio,
    this.item,
  );
  final Dio dio;
  String item;

  Future<List<ProductModel>> fetchProductItems();
}

class GeneralService extends IGeneralService {
  GeneralService(
    super.dio,
    super.item,
  );

  @override
  Future<List<ProductModel>> fetchProductItems() async {
    List<ProductModel> products = [];
    final response = await dio.get("/$item");
    final resData = response.data;
    if (response.statusCode == HttpStatus.ok) {
      for (dynamic item in resData) {
        ProductModel proModel = ProductModel(
          id: item["id"],
          title: item["title"],
          price: item["price"],
          description: item["description"],
          category: item["category"],
          image: item["image"],
        );
        products.add(proModel);
      }
      return products;
    }
    throw "Something went wrong";
  }
}
