// ignore_for_file: deprecated_member_use, duplicate_ignore, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  //String? userPhoto = FirebaseAuth.instance.currentUser?.photoURL!;;

  String username = "";

  updateUsername(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //backgroundColor: const Color(0xff23286b),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Update Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Color(0xff23286b)),
                          cursorColor: const Color(0xff23286b),
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Color(0xff23286b)),
                              hintText: 'Enter Username',
                              hintStyle: TextStyle(color: Color(0xff23286b)),
                              fillColor: Colors.pink,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: Color(0xff23286b)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                              )),
                          onChanged: (_val) {
                            username = _val;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: const Color(0xff23286b),
                minWidth: 50,
                height: 40,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: const Color(0xff23286b),
                minWidth: 50,
                height: 40,
                onPressed: () {
                  setState(() {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(username);
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Future getImage() async {
    //   // ignore: invalid_use_of_visible_for_testing_member
    //   var image = await ImagePicker.platform.getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: null,
    //   maxHeight: null,
    //   imageQuality: null,
    //   preferredCameraDevice: CameraDevice.rear,
    // );

    //   setState(() {
    //     _image = image as File;
    //       print('Image Path $_image');
    //   });
    // }

    // Future uploadPic(BuildContext context) async{
    //   String fileName = basename(_image.path);
    //    var firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    //    // ignore: unused_local_variable
    //    var uploadTask = firebaseStorageRef.putFile(_image);
    //    // ignore: duplicate_ignore
    //    setState(() {
    //       print("Profile Picture uploaded");
    //       // ignore: deprecated_member_use
    //       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    //    });
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Color(0xff23286b),
                      child: ClipOval(
                        child: SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: Image(image: AssetImage('./images/pv.jpg')),
                          // ignore: unnecessary_null_comparison
                          // ignore: unnecessary_null_comparison
                          // ignore: unnecessary_null_comparison
                          // ignore: unnecessary_null_comparison
                          // child: (_image!=null)?Image.file(
                          //   _image,
                          //   fit: BoxFit.fill,
                          // ):Image.network(
                          //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 60.0),
                  //   child: IconButton(
                  //     icon: const Icon(
                  //       FontAwesomeIcons.camera,
                  //       size: 30.0,
                  //     ),
                  //     onPressed: () {},
                  //     // onPressed: () {
                  //     //   getImage();
                  //     // },
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff23286b),
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Username : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text('${user?.displayName.toString()}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  updateUsername(context);
                                },
                                child: const Icon(
                                  FontAwesomeIcons.pen,
                                  color: Color(0xff23286b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff23286b),
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                        Text('${user?.email.toString()}',
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            FontAwesomeIcons.pen,
                            color: Color(0xff23286b),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: const Color(0xff23286b),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: const Color(0xff23286b),
                    onPressed: () {
                      //uploadPic(context);
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



// FadeInImage.assetNetwork(
//   placeholder: 'assets/images/placeholder.png', // Before image load
//   image: 'https://picsum.photos/id/237/200/300', // After image load
//   height: 200,
//   width: 300,
// )