import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/auth_controller.dart';
import 'package:firebase_authentication/screens/homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.watch<AuthController>().stream(),
            initialData: null)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: HomePage()),
    );
  }
}
