import 'package:flutter/material.dart';

class line extends StatelessWidget {
  const line({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(child: Divider()),
      Text("OR"),
      Expanded(child: Divider()),
    ]);
  }
}
