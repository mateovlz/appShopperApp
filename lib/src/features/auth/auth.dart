import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart' as Fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopper_mv_app/src/features/auth/user.dart';

final authProvider = ChangeNotifierProvider<Auth>((ref) {
  return Auth();
});

class Auth extends ChangeNotifier{

  final Fb.FirebaseAuth _firebaseAuth = Fb.FirebaseAuth.instance;

  Usera? _userFromFirebase(Fb.User? user){
    if(user==null){
      return null;
    }
    //print('Here2');
    return Usera(user.uid, user.email.toString());
  }

  Stream<Usera?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<Usera?> signInWithEmailAndPassword (String email, String password ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return _userFromFirebase(credential.user);
  }

  Future<Usera?> createUserWithEmailAndPassword (String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return _userFromFirebase(credential.user);
  }

  Future<void> signOutUser () async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}