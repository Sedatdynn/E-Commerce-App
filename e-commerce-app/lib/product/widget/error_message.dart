import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final data = "Something wrong";
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
