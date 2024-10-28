import 'dart:developer';

import 'package:ecommerce/api/api_service.dart';
import 'package:ecommerce/database/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/product_detail.dart';
import 'package:ecommerce/widgets/product_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  late List<Product>? _products = [];
  var dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    var count = await dbHelper.getCountProducts();

    if (count != null && count > 0) {
      log("BUSCOU PRODUTOS DO BANCO DE DSDOS");
      _products = (await dbHelper.getProducts());
    } else {
      _products = (await ApiService().getAllProducts())!;

      log("BUSCOU PRODUTOS DA API");
      log(_products.toString());

      _products?.forEach((product) async => {
            await dbHelper.inserir({
              'id': product.id,
              'title': product.title,
              'price': product.price,
              'category': product.category,
              'description': product.description,
              'image': product.image,
              'ratingRate': product.rating.rate,
              'ratingCount': product.rating.count,
            })
          });

      // var row = { DatabaseHelper.columnId: product.id, DatabaseHelper.columnTitle: product.title};

      // dbHelper.inserir(product);
    }

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _syncProducts() {
    dbHelper.deletarTodos();

    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Compraki'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _syncProducts,
        child: const FaIcon(FontAwesomeIcons.rotate),
      ),
      body: _products == null || _products!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: _products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(product: _products![index]),
                      ),
                    )
                  },
                  child: ProductWidget(
                      title: _products![index].title,
                      price: _products![index].price,
                      category: _products![index].category,
                      image: _products![index].image,
                      rating: _products![index].rating),
                );
              },
            ),
    );
  }
}
