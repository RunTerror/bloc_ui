import 'dart:developer';

import 'package:assignment/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:assignment/presentation/auth/bloc/auth/auth_event.dart';
import 'package:assignment/presentation/auth/bloc/auth/auth_state.dart';
import 'package:assignment/presentation/auth/screen/otp_screen.dart';
import 'package:assignment/presentation/auth/widgets/buttons.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _controller = TextEditingController();

  String dialcode = '';

  @override
  void dispose() {
    _controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(100),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthErrorState) {
                return Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const Gap(10);
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CountryCodePicker(
                  onChanged: (value) {
                    dialcode = value.dialCode.toString();
                  },
                  onInit: (value) {
                    dialcode = value!.dialCode.toString();
                  },
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      authBloc.add(TextChangeEvent(lenght: value.length));
                    },
                    decoration: const InputDecoration(),
                  )),
            ],
          ),
          const Gap(20),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Buttons().customButton(
                  (state is AuthValidState)
                      ? () async {
                          log(dialcode);
                          final mobilenumber = dialcode + _controller.text;
                          log(mobilenumber);
                          authBloc.add(AuthSubmittedEvent(
                              mobileNumber: mobilenumber,
                              fullPhoneNumber: _controller.text));
                          await Future.delayed(const Duration(seconds: 1), () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OtpScreen(mobileNumber: mobilenumber);
                              },
                            ));
                          });
                        }
                      : null,
                  (state is AuthLoadingState)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 35, 105, 163),
                          ),
                        )
                      : const Text(
                          'Send OTP',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                  (state is AuthValidState) ? Colors.blue : Colors.grey);
            },
          )
        ],
      ),
    ));
  }
}
