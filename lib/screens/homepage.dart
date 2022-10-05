import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/auth_controller.dart';
import 'package:firebase_authentication/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthController>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoginPage();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => context.read<AuthController>().signOut(),
                  icon: const Icon(Icons.logout),
                  splashRadius: 20,
                )
              ],
            ),
            body: const Center(
              child: Text('Home Page'),
            ),
          );
        });
  }
}
