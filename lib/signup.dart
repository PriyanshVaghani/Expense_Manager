// ignore_for_file: avoid_print, empty_catches

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser;

  var email = "";
  var password = "";
  var confirmPassword = "";
  late String name;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'Registered Sucessfull. Please Login...',
              style: TextStyle(fontSize: 20),
            )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weal-password') {
          //print('Password Provided is too week');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Password Provided is too week',
                style: TextStyle(fontSize: 20),
              )));
        } else if (e.code == 'email-already-in-use') {
          //print('Account Already exists');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Account Already exists',
                style: TextStyle(fontSize: 20),
              )));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "Password and confirm Password doesn't match",
            style: TextStyle(fontSize: 20),
          )));
    }
  }

  int income = 0, expense = 0, balance = 0;
  CollectionReference totaldata = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AmountDetails');

  void add() {
    FirebaseAuth.instance.currentUser?.updateDisplayName(name);

    CollectionReference totaldata = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AmountDetails');

    var data = {
      'grand_income': income,
      'grand_expense': expense,
      'grand_balance': balance,
      'created': DateTime.now(),
    };
    totaldata.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/sss.png'),
          ),
        ),
        child: Form(
            key: _formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Create Your Account',
                              speed: const Duration(milliseconds: 200),
                              textStyle: const TextStyle(
                                  color: Color(0xFFFFCF66),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 0.0,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    Shadow(
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 15.0,
                                      color: Color.fromARGB(200, 173, 216, 230),
                                    ),
                                  ]),
                            )
                          ],
                          repeatForever: false,
                        )
                        // Text(
                        //   'Create Your Account',
                        //   style: TextStyle(
                        //       //color: Colors.yellow,
                        //       fontSize: 30,
                        //       fontWeight: FontWeight.bold,
                        //       shadows: <Shadow>[
                        //         //   Shadow(
                        //         //   offset: Offset(1.0, 1.0),
                        //         //   blurRadius: 0.0,
                        //         //   color: Color.fromARGB(255, 255, 255, 255),
                        //         // ),
                        //         // Shadow(
                        //         //   offset: Offset(5.0, 5.0),
                        //         //   blurRadius: 15.0,
                        //         //   color: Color.fromARGB(200, 173, 216, 230),
                        //         // ),
                        //         Shadow(
                        //           offset: Offset(1.0, 1.0),
                        //           blurRadius: 3.0,
                        //           color: Color.fromARGB(1, 0, 0, 0),
                        //         ),
                        //         Shadow(
                        //           offset: Offset(3.0, 3.0),
                        //           blurRadius: 8.0,
                        //           //color: Color.fromARGB(125, 0, 0, 255),
                        //           color: Color.fromARGB(200, 173, 216, 230),
                        //         ),
                        //       ]),
                        // )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.yellow),
                          hintText: 'Enter your Name',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15)),
                      onChanged: (_val) {
                        name = _val;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.yellow),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15)),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.yellow),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15)),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Paaword';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      autofocus: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.yellow),
                          hintText: 'Re-enter your Password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15)),
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Paaword';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       width: 100,
                  //       child: MaterialButton(
                  //         onPressed: () {
                  //           if (_formKey.currentState!.validate()) {
                  //             setState(() {
                  //               email = emailController.text;
                  //               password = passwordController.text;
                  //               confirmPassword =
                  //                   confirmPasswordController.text;
                  //             });
                  //             registration();
                  //           }
                  //         },
                  //         color: Colors.black,
                  //         child: const Text(
                  //           'Signup',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      //alignment: Alignment.center,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 80),
                      decoration: BoxDecoration(
                        //color: const Color(0xff23286b),
                        color: Colors.black,

                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                              confirmPassword = confirmPasswordController.text;
                            });
                            registration();
                            add();
                          }
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an Account ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const Login(),
                                    transitionDuration:
                                        const Duration(seconds: 0)));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))
                    ],
                  )
                ]))),
      ),
    ));
  }
}
