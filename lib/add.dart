import 'dart:math';

import 'package:app/add_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Transaction');
  Future<QuerySnapshot<Map<String, dynamic>>> totaldata = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('AmountDetails').get();

  List<Color> myColors = [
    Colors.yellow.shade100,
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.deepPurple.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.cyanAccent.shade100,
    Colors.blueAccent.shade100,
    Colors.purple.shade100,
    Colors.cyan.shade100,
    Colors.teal.shade100,
    Colors.orangeAccent.shade100,
    Colors.pink.shade100,
  ];

  late String title;
  late String des;
  late int amount;
  bool value = true;

  Future<void> updateTransactionuser() async {
    var totaldata = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();
    double balance = totaldata['grand_balance'] + amount;
    double income = totaldata['grand_income'] + amount;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'grand_balance': balance,
      'grand_income': income,
    });
  }

  Future<void> add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Transaction');

    var data = {
      'title': title,
      'amount': amount,
      'des': des,
      'created': DateTime.now(),
    };
    ref.add(data).whenComplete(() => Navigator.pop(context));
  }

  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  int type = 1;

  popupbox(BuildContext context) {
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
                      'Add Transaction',
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
                              labelText: 'Transaction',
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Color(0xff23286b)),
                              hintText: 'Enter Transaction Type',
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
                            title = _val;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Color(0xff23286b)),
                          cursorColor: const Color(0xff23286b),
                          decoration: const InputDecoration(
                            labelText: 'Ammount',
                            labelStyle: TextStyle(
                                fontSize: 20, color: Color(0xff23286b)),
                            hintText: 'Enter Ammount',
                            hintStyle: TextStyle(color: Color(0xff23286b)),
                            fillColor: Colors.pink,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Color(0xff23286b)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                            ),
                          ),
                          onChanged: (_val) {
                            amount = int.parse(_val);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Color(0xff23286b)),
                          cursorColor: const Color(0xff23286b),
                          decoration: const InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Color(0xff23286b)),
                              hintText: 'Enter Description',
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
                            des = _val;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Transform.scale(
                          scale: 2,
                          child: Switch.adaptive(
                              value: value,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value;
                                });
                              }),
                        )
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
                  updateTransactionuser();
                  add();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your All Transaction Data',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff23286b),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const Details()));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Details()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff23286b).withOpacity(0.95),
      ),
      body: RefreshIndicator(
        onRefresh: add,
        child: FutureBuilder<QuerySnapshot>(
            future: ref.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Random random = Random();
                      Color bg = myColors[random.nextInt(4)];
                      Map? data = snapshot.data?.docs[index].data() as Map?;
                      DateTime mydateTime = data!['created'].toDate();
                      return Card(
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data['title']}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'late',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${data['amount']}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'late',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${data['des']}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'late',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    '${data['type']}',
                                    style: const TextStyle(
                                      fontFamily: 'late',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(DateFormat.yMMMd()
                                      .add_jm()
                                      .format(mydateTime)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Loadding...'),
                );
              }
            }),
      ),
    );
  }
}
