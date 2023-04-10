import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store/provider/cart_provider.dart';
import 'package:multi_store/provider/product_provider.dart';
import 'package:multi_store/vendor/views/auth/screens/landing_screen.dart';
import 'package:multi_store/vendor/views/auth/screens/main_vendor_sceen.dart';
import 'package:multi_store/vendor/views/auth/screens/upload_screen.dart';
import 'package:multi_store/vendor/views/auth/screens/vendor_logout_screen.dart';
import 'package:multi_store/vendor/views/auth/vendor_auth.dart';
import 'package:multi_store/views/buyers/auth/login_screen.dart';
import 'package:multi_store/views/buyers/auth/register_screen.dart';
import 'package:multi_store/views/buyers/inner_screen/edit_profile.dart';
import 'package:multi_store/views/buyers/main_sceen.dart';
import 'package:multi_store/views/buyers/nav_screen/account_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/costomer_login_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/home_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/post_frame_callback.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/Test_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/line.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) {
        return ProductProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (_) {
        return CartProvider();
      },
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home: PostFrameCallbackSample(),
      builder: EasyLoading.init(),
    );
    //VenderAuthScreen
    //LoginScreen
  }
}
