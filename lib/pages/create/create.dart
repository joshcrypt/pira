import "package:flutter/material.dart";
import "package:pira/utilities/common_form.dart";

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  static const String formName = "Create";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(formName),
          ],
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: CommonForm(buttonTitle: formName)),
          ),
        ],
      ),
    );
  }
}
