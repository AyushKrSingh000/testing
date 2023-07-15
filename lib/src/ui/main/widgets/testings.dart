import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.white,
        child: SizedBox(
          height: 95,
          width: 95,
          child: Transform.scale(
            scale: 0.6,
            child: Image.asset(
              'images/ic_launcher.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
