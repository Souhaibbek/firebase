import 'package:firebase_auth/firebase_auth.dart';

abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  final String uid;

  AppLoginSuccessState(this.uid);
}

class AppLoginErrorState extends AppLoginStates {
  final FirebaseAuthException error;

  AppLoginErrorState(this.error);
}

class AppLoginPasswordChangeVisibilityState extends AppLoginStates {}
