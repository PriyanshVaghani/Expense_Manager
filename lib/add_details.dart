import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String des;
  late int amount;
  bool value = true;

  double balace = 0;
  double income = 0;
  double expense = 0;

  Future<void> add() async {
    if (value) {
      setState(() {
        income += amount;
        balace += amount;
      });
    } else {
      setState(() {
        expense += amount;
        balace -= amount;
      });
    }
    CollectionReference ref = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Transaction');

    var data = {
      'title': title,
      'amount': amount,
      'des': des,
      'type': value ? 'Expense' : 'Income',
      'created': DateTime.now(),
    };
    ref.add(data).whenComplete(() => Navigator.pop(context));
  }

  Future<void> updateTransactionuser() async {
    var totaldata = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  
    double balance = totaldata['grand_balance'] + amount;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("amount"+amount.toString())),);
    double income = totaldata['grand_income'] + amount;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'grand_balance': balance,
      'grand_income': income,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Balance $income',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff23286b),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Transform.scale(
                scale: 1.5,
                child: Switch.adaptive(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    }),
              ),
              // child: LiteRollingSwitch(
              //   value: true,
              //   textOn: "Expense",
              //   textOff: "Income",
              //   iconOff: Icons.thumb_down,
              //   iconOn: Icons.thumb_up,
              //   textSize: 15,
              //   onChanged: (value) {
              //     setState(() {
              //       this.value = value;
              //     });
              //   },
              // ),
            )
          ],
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: TextFormField(
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
                              borderSide: BorderSide(color: Color(0xff23286b)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: const TextStyle(color: Color(0xff23286b)),
                        cursorColor: const Color(0xff23286b),
                        decoration: const InputDecoration(
                          labelText: 'Ammount',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Color(0xff23286b)),
                          hintText: 'Enter Ammount',
                          hintStyle: TextStyle(color: Color(0xff23286b)),
                          fillColor: Colors.pink,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: TextFormField(
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
                              borderSide: BorderSide(color: Color(0xff23286b)),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                        const SizedBox(
                          width: 50,
                        ),
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: const Color(0xff23286b),
                          minWidth: 50,
                          height: 40,
                          onPressed: () {
                            updateTransactionuser();
                            add();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
