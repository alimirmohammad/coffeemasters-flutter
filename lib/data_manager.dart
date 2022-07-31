import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:coffee_masters/data_model.dart';

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  Future<List<Category>> fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Category>> getMenu() async {
    _menu ??= await fetchMenu();
    return _menu!;
  }

  void cartAdd(Product product) {
    try {
      final existingItem =
          cart.firstWhere((item) => item.product.id == product.id);
      existingItem.quantity++;
    } catch (e) {
      cart.add(ItemInCart(product: product, quantity: 1));
    }
  }

  void cartRemove(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
  }

  double cartTotal() {
    var total = 0.0;
    for (var item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
