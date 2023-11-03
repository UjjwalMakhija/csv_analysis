// import 'package:csv_analysis/features/analysis/ui/analysis_page.dart';
import 'package:csv_analysis/features/home/ui/home_page.dart';
// import 'package:csv_analysis/features/random/ui/test_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_storage/firebase_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(
    
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android
  );
  runApp(const MyApp());
} 

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: homepg(),
      home: homepg(),
      
    );
  }
}
