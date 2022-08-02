import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AkabaloFirebaseUser {
  AkabaloFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AkabaloFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AkabaloFirebaseUser> akabaloFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AkabaloFirebaseUser>(
        (user) => currentUser = AkabaloFirebaseUser(user));
