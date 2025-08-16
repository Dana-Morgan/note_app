import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget{
   IconData icon;
   VoidCallback onPressed;

  ActionIcon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white60,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, size: 28, color: Colors.white),
            splashRadius: 24,
          ),
        ),
      );
    }

  }
