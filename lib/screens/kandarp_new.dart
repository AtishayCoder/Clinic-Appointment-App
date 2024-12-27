import 'package:change_case/change_case.dart';
import 'package:clinic_appointment/utility/constants.dart';
import 'package:clinic_appointment/utility/error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:telephony_sms/telephony_sms.dart';

final _firestore = FirebaseFirestore.instance;

class KandarpNew extends StatefulWidget {
  const KandarpNew({super.key});

  @override
  State<KandarpNew> createState() => _KandarpNewState();
}

class _KandarpNewState extends State<KandarpNew> {
  late String name;
  late String date;
  late String number;
  late String time;
  bool showProgress = false;
  final telephony = TelephonySMS();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  void popScreen() {
    Navigator.pop(context);
  }

  void pushError() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showProgress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('New Patient', style: textStyle),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: numberController,
                  onChanged: (value) {
                    number = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: timeController,
                  onChanged: (value) {
                    time = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: dateController,
                  onChanged: (value) {
                    date = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                MaterialButton(
                  onPressed: () async {
                    _firestore.collection("kandarp's patients").add({
                      'Name': name,
                      'Phone': number,
                      'Time': time,
                      'Date': date,
                    });
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      await telephony.sendSMS(
                        message:
                            'Dear ${name.toCapitalCase()}, your appointment is fixed with Dr. Kandarp Vidyarthi at $time on ${date.split('')[0]}${date.split('')[1]}/${date.split('')[2]}${date.split('')[3]}/${date.split('')[4]}${date.split('')[5]}.',
                        phone: number,
                      );
                    } catch (e) {
                      pushError();
                    }
                    setState(() {
                      showProgress = false;
                    });
                    popScreen();
                  },
                  color: Colors.lightBlue,
                  elevation: 5.0,
                  minWidth: double.infinity,
                  height: 35,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Text('Create Patient'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
