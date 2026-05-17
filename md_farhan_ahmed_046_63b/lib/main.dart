import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/auth/auth_gate.dart';
import 'package:md_farhan_ahmed_046_63b/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Supabase.initialize(
     url:'https://mnlzxjfntvkfrwemskpm.supabase.co',
     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ubHp4amZudHZrZnJ3ZW1za3BtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc3ODYxNDcsImV4cCI6MjA5MzM2MjE0N30.jzKSjDC8YVbThynL-eTDsBQ0pkSdzXSyTZR06baENIc',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const  MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AuthGate(),
       // home: StopwatchPage(),
      // home:UploadPage(),

     );
  }
}


