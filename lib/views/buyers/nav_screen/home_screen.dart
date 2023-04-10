import 'package:flutter/material.dart';
import 'package:multi_store/views/buyers/nav_screen/costomer_login_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/search_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/banner_widget.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/category_text.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/dummy_search_widget_1.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/line.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/search_input_widget.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SizedBox(
            height: 0,
          ),
          DummySearchWidget1(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
          SizedBox(
            height: 8,
          ),
          //*SearchInputwidget(),
          BannerWidget(),
          CategoryText(),
          //CostomerAuthScreen()
        ],
      ),
    );
  }
}
