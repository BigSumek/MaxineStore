import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:multi_store/vendor/views/auth/screens/landing_screen.dart';
import 'package:multi_store/views/buyers/auth/register_screen.dart';
import 'package:multi_store/views/buyers/main_sceen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/main_product_widget.dart';

class CostomerAuthScreen extends StatelessWidget {
  const CostomerAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: ''),
              PhoneAuthProvider(),
              FacebookProvider(clientId: ''),
            ],
          );
        }

        return MainScreen();
      },
    );
  }
}

/*Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          'Login',
          style: TextStyle(letterSpacing: 0),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.shop),
          ),
        ],
      ),
      body:*/





























/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:multi_store/vendor/views/auth/screens/landing_screen.dart';
import 'package:multi_store/views/buyers/main_sceen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class CostomerAuthScreen extends StatefulWidget {
  const CostomerAuthScreen({super.key});

  @override
  State<CostomerAuthScreen> createState() => _VenderAuthScreenState();
}

class _VenderAuthScreenState extends State<CostomerAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,

      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                elevation: 2,
                backgroundColor: Colors.yellow.shade900,
                title: Text(
                  'Login',
                  style: TextStyle(letterSpacing: 0),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.shop),
                  ),
                ],
              ),
              body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }

        return LandingScreen();
      },
    );
              ,)
              ,);
        }

        // Render your application if authenticated
        return MainScreen();
      },
    );
  }
}



body: SignInScreen(providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId: '1:678645090549:android:2720d74dc0b0c22d10ddbc'),
              PhoneProviderConfiguration(),
            ]),*/
