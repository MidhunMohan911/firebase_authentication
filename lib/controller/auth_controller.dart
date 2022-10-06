import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<String> googleSignIn() async {
    try {
      _isLoading = true;
      notifyListeners();

      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        _isLoading = false;
        notifyListeners();
        return Future.value('Occured an error while sign in');
      }
      final credential = await result.authentication;
      final exists = await _fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return Future.value("User doesn't exists");
      }
      await _fb.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: credential.accessToken, idToken: credential.idToken));
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> googleSignUp() async {
    try {
      _isLoading = true;
      notifyListeners();

      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        _isLoading = false;
        notifyListeners();
        return Future.value('Occured an error while sign in');
      }
      final credential = await result.authentication;
      final exists = await _fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isNotEmpty) {
        _isLoading = false;
        notifyListeners();
        return Future.value('User already exists');
      }
      await _fb.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: credential.accessToken, idToken: credential.idToken));
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
