import 'package:app/animated_indicator.dart';
import 'package:app/login.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageController = PageController(initialPage: 0);
  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,
      body: SafeArea(
          child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Slide(
            imageAsset: Image.asset('images/on_b1.png'),
            title: "Secure Your Data",
            subtitle:
                "“Sometimes it's about the money but rather the process of managing money.”",
            onNext: nextPage,
            page: 1,
          ),
          Slide(
            imageAsset: Image.asset('images/on_b2.png'),
            title: "Money Management",
            subtitle:
                "“If you don't know to care for money, money will stay away from you.”",
            onNext: nextPage,
            page: 2,
          ),
          Slide(
            imageAsset: Image.asset('images/on_b3.png'),
            title: "User Friendly UI",
            subtitle: "“People ignore design that ignores people.”",
            onNext: nextPage,
            page: 3,
          ),
          //const Login()
        ],
      )),
    );
  }
}

class Slide extends StatelessWidget {
  final Widget imageAsset;
  final String title, subtitle;
  final VoidCallback onNext;
  final int page;

  const Slide({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.onNext,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23286b),
      body: Column(
        children: [
          Expanded(
            child: imageAsset,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                ProgressButton(onNext: onNext),
              ],
            ),
          ),
          // GestureDetector(
          //   //onTap: onNext,
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
          //   },
          //   child: const Text('Skip',style: kSubTitleStyle,)),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: Text(
                page == 3 ? 'Get Start' : 'Skip',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          AnimatedIndicator(
            duration: const Duration(seconds: 10),
            size: 75,
            callback: onNext,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 60,
                width: 60,
                child: Center(
                  child: IconButton(
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward),
                    iconSize: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
