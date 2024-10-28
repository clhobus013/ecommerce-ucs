import 'package:ecommerce/models/Rate.dart';
import 'package:ecommerce/widgets/rate_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatefulWidget {
  final String title;
  final num price;
  final String? category;
  final String image;
  final Rate rating;

  const ProductWidget(
      {super.key,
      required this.title,
      required this.price,
      required this.category,
      required this.image,
      required this.rating});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  var f = NumberFormat("#,###.00", "pt_BR");

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Image.network(
              widget.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.category ?? "",
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(150, 59, 59, 59)),
              ),
              RateWidget(rate: widget.rating.rate, count: widget.rating.count),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "R\$ ${f.format(widget.price)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
