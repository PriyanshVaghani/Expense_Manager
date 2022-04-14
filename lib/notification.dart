import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notification",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 8, 6, 90),
          //brightness: Brightness.dark,
        ),
        body: Column(
          children: [
            displaynotification('Report', "Your Weekly Report is ready",
                "09:10 am", "12-10-2020"),
            displaynotification(
                'Warnning',
                "Please Enter your Last month\n Income",
                "09:10 am",
                "12-10-2020"),
            displaynotification(
                'Profile', "Update Your Profile", "09:10 am", "12-10-2020"),
            displaynotification(
                'Warnning',
                "Last Month Expense is higher\nthan Income",
                "09:10 am",
                "12-10-2020"),
            displaynotification(
                'Message', "Notification", "09:10 am", "12-10-2020")
          ],
        ));
  }

  Container displaynotification(
      String title, String desc, String time, String date) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 8, 6, 90),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade300),
                child: Icon(
                  Icons.notifications,
                  size: 25,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: "$title : ",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: " $desc",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400))
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$date ', style: const TextStyle(fontSize: 10)),
                          Text(
                            ' $time',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
