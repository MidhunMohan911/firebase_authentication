// ignore_for_file: use_build_context_synchronously

import 'package:firebase_authentication/controller/auth_controller.dart';
import 'package:firebase_authentication/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void buildSignIn(AuthController authProvider) async {
    final msg = await authProvider.signIn(_email.text, _pass.text);
    if (msg == '') return;
    print(msg);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  void buildGoogleSignIn(AuthController authProvider) async {
    final msg = await authProvider.googleSignIn();
    if (msg == '') return;
    print(msg);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    AuthController authController = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Firebase',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
              ),
              const Text('Sign into your account'),
              const SizedBox(height: 20),
              SizedBox(
                width: w * .9,
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      label: const Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: w * .9,
                child: TextField(
                  controller: _pass,
                  decoration: InputDecoration(
                      label: const Text('Password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [Text('Forgot your Password ?')],
                ),
              ),
              SizedBox(height: h * .05),
              authController.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        buildSignIn(authController);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
              SizedBox(height: h * .01),
              const Text('or'),
              SizedBox(height: h * .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: h * .12,
                    width: w * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/Apple-logo.png',
                          height: 40,
                          width: 40,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign in with Apple',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: h * .12,
                    width: w * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                          height: 40,
                          width: 40,
                        ),
                        TextButton(
                            onPressed: () => buildGoogleSignIn(authController),
                            child: const Text(
                              'Sign in with google',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? "),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          )),
                      child: const Text('Create'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
