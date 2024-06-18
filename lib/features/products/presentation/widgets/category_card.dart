import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  const CategoryCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffffd3ee),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
