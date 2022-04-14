import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/forgot_password.dart';
import 'package:app/navi.dart';
import 'package:app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const NaviBar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'No user found for this email',
              style: TextStyle(fontSize: 20),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              'Wrong password!!!\nPlease enter valid password',
              style: TextStyle(fontSize: 20),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool userlogin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _login() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAccountauthentication =
        await googleSignInAccount?.authentication
            .whenComplete(() => const NaviBar());
    AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAccountauthentication!.idToken,
        accessToken: googleSignInAccountauthentication.accessToken);
    //final UserCredential authResult =
    await _auth.signInWithCredential(authCredential);

    setState(() {
      userlogin = true;
    });
  }

  // try {
  //   await _googleSignIn.signIn().whenComplete(() => const HomePage());
  // } catch (e) {
  //   // ignore: avoid_print
  //   print(e);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userlogin
          ? const NaviBar()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // width: double.infinity,
                // height: double.infinity,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'Login',
                                    speed: const Duration(milliseconds: 200),
                                    textStyle: const TextStyle(
                                        color: Color(0xFFFFCF66),
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 0.0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          Shadow(
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 15.0,
                                            color: Color.fromARGB(
                                                200, 173, 216, 230),
                                          ),
                                        ]),
                                  )
                                ],
                                repeatForever: false,
                              )
                              // Text(
                              //   'Login',
                              //   style: TextStyle(
                              //       color: Color(0xFFFFCF66),
                              //       fontSize: 50,
                              //       fontWeight: FontWeight.bold,
                              //       shadows: <Shadow>[
                              //         Shadow(
                              //           offset: Offset(1.0, 1.0),
                              //           blurRadius: 0.0,
                              //           color:
                              //               Color.fromARGB(255, 255, 255, 255),
                              //         ),
                              //         Shadow(
                              //           offset: Offset(5.0, 5.0),
                              //           blurRadius: 15.0,
                              //           color:
                              //               Color.fromARGB(200, 173, 216, 230),
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
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15)),
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
                            //cursorColor: Colors.white,
                            autofocus: false,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                )),
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Paaword';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassword()));
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: MediaQuery.of(context).size.height * 0.05,
                        //       width: MediaQuery.of(context).size.height * 0.2,
                        //       child: MaterialButton(
                        //         onPressed: () {
                        //           if (_formKey.currentState!.validate()) {
                        //             setState(() {
                        //               email = emailController.text;
                        //               password = passwordController.text;
                        //             });
                        //             userLogin();
                        //           }
                        //         },
                        //         color: Colors.black,
                        //         child: const Text(
                        //           'Login',
                        //           style: TextStyle(
                        //             fontSize: 18,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(20)),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
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
                                  });
                                  userLogin();
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  minimumSize: const Size(100, 50)),
                              onPressed: () async {
                                await _login();
                                // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                                // provider.googleLogin().whenComplete(() => const HomePage());
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: Color(0xff23286b),
                              ),
                              label: const Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff23286b)),
                              )),
                        ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an Account ? ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a, b) =>
                                            const Signup(),
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
