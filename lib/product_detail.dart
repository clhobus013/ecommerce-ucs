import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/widgets/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatelessWidget {
  // In the constructor, require a Todo.
  const ProductDetail({super.key, required this.product});

  // Declare a field that holds the Todo.
  final Product product;

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat("#,###.00", "pt_BR");
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(product.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                RateWidget(
                  rate: product.rating.rate,
                  count: product.rating.count,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "R\$ ${f.format(product.price)}",
                  style: const TextStyle(fontSize: 18),
                ),
                TextButton(onPressed: () => {}, child: Text("Comprar")),
              ],
            ),
            Text(
              "Descrição:",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
