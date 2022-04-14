import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          const Text('Somthing went to wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return MaterialApp(
          title: 'Login page',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            splash: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: Expanded(
                            child: Image.asset(
                          'images/group.png',
                          height: 50,
                          width: 50,
                        )),
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ],
                ),
              ],
            ),
            duration: 3000,
            backgroundColor: const Color(0xff23286b),
            splashTransition: SplashTransition.scaleTransition,
            nextScreen: const Onboarding(),
          ),
        );
      },
    );
  }
}
