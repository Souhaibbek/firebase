
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/models/user_model.dart';

import 'logstates.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);


  UserModel? userModel;

  void userLogin({

    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user!.uid);


      emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(AppLoginErrorState(error));
    });

  }

  IconData suffix = Icons.visibility;
  bool isPassShow = true;

  void changeSuffixIcon() {
    isPassShow = !isPassShow;
    suffix = isPassShow ? Icons.visibility : Icons.visibility_off;
    emit(AppLoginPasswordChangeVisibilityState());
  }
}
