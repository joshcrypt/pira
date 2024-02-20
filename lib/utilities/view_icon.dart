import "package:flutter/material.dart";

class ViewIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const ViewIcon({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: Colors.grey[100],
    );
  }
}
