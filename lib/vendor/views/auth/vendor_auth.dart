import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:multi_store/vendor/views/auth/screens/landing_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({super.key});

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
            ],
          );
        }

        return LandingScreen();
      },
    );
  }
}


























/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:multi_store/vendor/views/auth/screens/landing_screen.dart';

class VenderAuthScreen extends StatefulWidget {
  const VenderAuthScreen({super.key});

  @override
  State<VenderAuthScreen> createState() => _VenderAuthScreenState();
}

class _VenderAuthScreenState extends State<VenderAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
                clientId: '1:678645090549:android:2720d74dc0b0c22d10ddbc'),
            PhoneProviderConfiguration(),
          ]);
        }

        // Render your application if authenticated
        return LandingScreen();
      },
    );
  }
}*/
