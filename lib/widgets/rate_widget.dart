import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateWidget extends StatefulWidget {
  final num rate;
  final int count;

  const RateWidget({super.key, required this.rate, required this.count});

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const FaIcon(
        FontAwesomeIcons.solidStar,
        size: 20,
        color: Color.fromARGB(255, 255, 207, 76),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Text(
          widget.rate.toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ),
      Text(
        "(${widget.count})",
        style: const TextStyle(fontSize: 12),
      )
    ]);
  }
}
