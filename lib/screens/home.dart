import 'package:flutter/material.dart';
import 'kandarp_appointments.dart';
import 'package:clinic_appointment/utility/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Appointments', style: textStyle,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.blueGrey,
                child: TextButton(
                  child: const Text('See appointments for Kandarp Vidyarthi', style: textStyle,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const KandarpAppointments();
                    }));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
