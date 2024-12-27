import 'package:another_telephony/telephony.dart';
import 'package:change_case/change_case.dart';
import 'package:clinic_appointment/utility/error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final telephony = Telephony.instance;
final _firestore = FirebaseFirestore.instance;

class PatientContainer extends StatefulWidget {
  const PatientContainer({
    super.key,
    required this.name,
    required this.phone,
    required this.time,
    required this.date,
    required this.collection,
  });

  final String name;
  final String phone;
  final String time;
  final String collection;
  final String date;

  @override
  State<PatientContainer> createState() => _PatientContainerState();
}

class _PatientContainerState extends State<PatientContainer> {
  void errorPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
            onDoubleTap: () async {
              final matching =
                  await _firestore
                      .collection(widget.collection)
                      .where("Phone", isEqualTo: widget.phone)
                      .get();
              for (final doc in matching.docs) {
                try {
                  telephony.sendSms(
                    to: widget.phone,
                    message:
                        'Dear ${widget.name.toCapitalCase()}, your appointment has been cancelled due to some emergency. Kindly fix another date for your appointment.',
                  );
                } catch (e) {
                  errorPage();
                } finally {
                  setState(() {});
                  await doc.reference.delete();
                }
              }
            },
            child: Container(
              color: Colors.lightBlue.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${widget.name.toCapitalCase()}',
                    style: const TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    'Phone: ${widget.phone}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    'Time: ${widget.time}',
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  Text(
                    'Date: ${widget.date}',
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () async {
              final matching =
                  await _firestore
                      .collection(widget.collection)
                      .where("Phone", isEqualTo: widget.phone)
                      .get();

              for (final doc in matching.docs) {
                doc.reference.delete();
                setState(() {});
              }
            },
            color: Colors.lightGreenAccent,
            hoverColor: Colors.lightGreen,
            hoverElevation: 15.0,
            elevation: 10.0,
            child: const Text('Delete patient'),
          ),
        ],
      ),
    );
  }
}
