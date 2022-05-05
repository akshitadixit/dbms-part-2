import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/pages/members_page.dart';
import 'package:travel_app/pages/onboarding_page.dart';
import 'package:travel_app/pages/user_profile.dart';
import 'package:travel_app/services/auth.dart';
import 'package:travel_app/pages/bookmarks_page.dart';
import 'package:travel_app/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBVab5VmfFVIgISPhF2mw6--d1NFM7gpqw",
          projectId: "mum-assign",
          appId: "1:1075483887376:android:8a51fcab0d5d02144ac795",
          messagingSenderId: "1075483887376",
          databaseURL:
              "https://mum-assign-default-rtdb.asia-southeast1.firebasedatabase.app"),
    );
  } catch (e) {
    print(e);
  }

  print('Firebase initialized!');

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (ctx) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class Home extends StatelessWidget {
  Home({Key? key, user}) : super(key: key);
  static var user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthUser?>(context);
    // print(user);
    if (user != null)
      return HomePage();
    else
      return OnBoardingPage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().onAuthChange,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: {
          '/boarding': (context) => OnBoardingPage(),
          '/home': (context) => HomePage(),
          '/user': (context) =>
              UserProfile(user: FirebaseAuth.instance.currentUser!.uid),
          '/bookmarks': (context) => BookmarksPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/marketplace': (context) => MembersPage(),
        },
      ),
    );
  }
}

/*
login_page line 127 and here line 65 -> passing of user variable after login isn't being done properly
*/