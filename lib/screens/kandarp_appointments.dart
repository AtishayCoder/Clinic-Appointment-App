import 'package:clinic_appointment/components/patient_stream.dart';
import 'package:clinic_appointment/utility/constants.dart';
import 'package:flutter/material.dart';

import 'kandarp_new.dart';

class KandarpAppointments extends StatelessWidget {
  const KandarpAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Kandarp Vidyarthi', style: textStyle),
      ),
      body: const PatientStream(collection: "kandarp's patients"),
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const KandarpNew();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
