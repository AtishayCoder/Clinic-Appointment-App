import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'patient_container.dart';

final _firestore = FirebaseFirestore.instance;

class PatientStream extends StatelessWidget {
  const PatientStream({super.key, required this.collection});

  final String collection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection(collection)
            .orderBy('Date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final patients = snapshot.data?.docs;
          List<Widget> patientList = [];
          for (var patient in patients!) {
            final patientName = patient.get('Name');
            final patientNumber = patient.get('Phone');
            final patientTime = patient.get('Time');
            final patientDate = patient.get('Date');
            patientList.add(PatientContainer(
              collection: collection,
              name: patientName.toString(),
              phone: patientNumber.toString(),
              time: patientTime.toString(),
              date: '${patientDate.toString().split('')[0]}${patientDate.toString().split('')[1]}/${patientDate.toString().split('')[2]}${patientDate.toString().split('')[3]}/${patientDate.toString().split('')[4]}${patientDate.toString().split('')[5]}',
            ));
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: patientList,
          );
        });
  }
}