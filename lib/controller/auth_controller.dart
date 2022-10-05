import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _fb;
  AuthController(this._fb);

  bool _isLoading = false;

  Stream<User?> stream() => _fb.authStateChanges();

  bool get loading => _isLoading;

  Future<String> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _fb.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<void> signOut() async {
    await _fb.signOut();
  }

  Future<String> signUp(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _fb.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }
}
