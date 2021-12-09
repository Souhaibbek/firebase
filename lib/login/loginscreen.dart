import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:spotifyfirebase/components/components.dart';
import 'package:spotifyfirebase/components/constants.dart';
import 'package:spotifyfirebase/layout/home_layout.dart';
import 'logincubit/logcubit.dart';
import 'logincubit/logstates.dart';

class AppLoginScreen extends StatefulWidget {
  @override
  _AppLoginScreenState createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  var logEmailController = TextEditingController();
  var logPasswordController = TextEditingController();
  var logFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if(state is AppLoginSuccessState){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: logFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: logEmailController,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Email';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            controller: logPasswordController,
                            prefix: Icons.lock,
                            onSubmit: (value) {
                              if (logFormKey.currentState!.validate()) {
                                // AppLoginCubit.get(context).userLogin(
                                //     email: logEmailController.text,
                                //     password: logPasswordController.text);
                              }
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Password';
                              }
                            },
                            isPass: AppLoginCubit.get(context).isPassShow,
                            suffix: AppLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              AppLoginCubit.get(context).changeSuffixIcon();
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! AppLoginLoadingState,
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          widgetBuilder: (context) {
                            return defaultButton(
                              onPressed: () {
                                if (logFormKey.currentState!.validate()) {
                                  AppLoginCubit.get(context).userLogin(
                                      email: logEmailController.text,
                                      password: logPasswordController.text);

                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                            );
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('D\'ont have an account ?'),
                            TextButton(
                              onPressed: () {
                              },
                              child: Text('Register !'.toUpperCase()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
