import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:telephony_sms/telephony_sms.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCmoMCbYBkOKkEy468H8EiErr-gwZgl_Nk',
      appId: '1:1080932914033:android:5c594f7673bfce6afbdcd0',
      messagingSenderId: '1080932914033',
      projectId: 'clinic-application-75aab',
    ),
  );
  runApp(
    MaterialApp(theme: ThemeData(useMaterial3: false), home: Appointments()),
  );
}

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((d) async {
      await TelephonySMS().requestPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
