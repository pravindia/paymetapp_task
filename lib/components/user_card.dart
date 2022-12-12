import 'package:flutter/material.dart';

class UserCards extends StatelessWidget {
  const UserCards({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.green.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white24,
            ),
            height: 40,
            width: 40,
          ),
          Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
