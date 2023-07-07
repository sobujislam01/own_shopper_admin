import 'package:flutter/material.dart';

class CustomProgressDialog extends StatelessWidget {
  final String title;
  const CustomProgressDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
        height: 100,
          width: 250,
          child: Center(child: const CircularProgressIndicator())),
    );
  }
}
