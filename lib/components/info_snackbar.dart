import 'package:flutter/material.dart';

Widget snackbarContent(String message) {
  return Row(
    children: [
      Text(message),
      const SizedBox(
        width: 10,
      ),
      const Icon(
        Icons.info,
        color: Colors.orange,
      ),
    ],
  );
}

class SnackbarContent extends StatelessWidget {
  const SnackbarContent(
    this.message, {
    super.key,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(message),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.info,
          color: Colors.orange,
        ),
      ],
    );
  }
}

SnackBar infoSnackbar(String message) {
  return SnackBar(
    content: snackbarContent(message),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}
