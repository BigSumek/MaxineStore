import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_store/views/buyers/nav_screen/cart_screen.dart';
//import 'package:marketky/constant/app_color.dart';
//import 'package:marketky/views/screens/cart_page.dart';
//import 'package:marketky/views/screens/message_page.dart';
//import 'package:marketky/views/screens/search_page.dart';
//import 'package:marketky/views/widgets/custom_icon_button_widget.dart';
//import 'package:marketky/views/widgets/dummy_search_widget2.dart';
import 'package:multi_store/views/buyers/nav_screen/search_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/custom_icon_button_widget.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/dummy_search_widget2.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int cartValue;
  final int chatValue;

  MainAppBar({
    required this.cartValue,
    required this.chatValue,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Colors.blue.shade500,
      elevation: 0,
      title: Row(
        children: [
          DummySearchWidget2(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
          CustomIconButtonWidget(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
            value: widget.cartValue,
            margin: EdgeInsets.only(left: 16),
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              color: Colors.white,
            ),
          ),
        ],
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
