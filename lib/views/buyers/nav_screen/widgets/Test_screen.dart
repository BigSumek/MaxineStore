import 'package:flutter/material.dart';
import 'package:multi_store/views/buyers/nav_screen/costomer_login_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/banner_widget.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/category_text.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/search_input_widget.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/welcome_text_widget.dart';

class Testlogin extends StatefulWidget {
  const Testlogin({super.key});

  @override
  State<Testlogin> createState() => _TestloginState();
}

class _TestloginState extends State<Testlogin> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //WelcomeText(),
          SizedBox(
            height: 100,
          ),
          Center(
            child: CircleAvatar(
              radius: 64,
              backgroundColor: Colors.yellow.shade900,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          CostomerAuthScreen(),
          // SearchInputwidget(),

          //CostomerAuthScreen()
        ],
      ),
    );
  }
}
