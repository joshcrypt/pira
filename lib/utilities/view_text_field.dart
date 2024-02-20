import "package:flutter/material.dart";

class ViewTextField extends StatelessWidget {
  final String title;

  const ViewTextField({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey[100],
      ),
    );
  }
}
