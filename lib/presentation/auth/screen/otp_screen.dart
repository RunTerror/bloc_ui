import 'package:assignment/presentation/auth/bloc/verify/verify_bloc.dart';
import 'package:assignment/presentation/auth/bloc/verify/verify_event.dart';
import 'package:assignment/presentation/auth/bloc/verify/verify_state.dart';
import 'package:assignment/presentation/auth/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpScreen extends StatelessWidget {
  final String mobileNumber;
  OtpScreen({super.key, required this.mobileNumber});

  final TextEditingController _controller = TextEditingController();

  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  String code = '';
  @override
  Widget build(BuildContext context) {
    final otpbloc = BlocProvider.of<OTPBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('OTP Verification'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: OtpPinField(
                  key: _otpPinFieldController,
                  autoFillEnable: false,
                  textInputAction: TextInputAction.done,
                  onCodeChanged: (code) {
                    otpbloc.add(OTPCodeChanged(code.length));
                    code = code;
                  },
                  maxLength: 6,
                  cursorColor: Colors.indigo,
                  upperChild: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.flutter_dash_outlined, size: 150),
                      SizedBox(height: 20),
                    ],
                  ),
                  showCustomKeyboard: false,
                  cursorWidth: 3,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                  onSubmit: (String text) {},
                  onChange: (String text) {
                    otpbloc.add(OTPCodeChanged(text.length));
                    code = text;
                  },
                ),

                // child: TextField(
                //   controller: _controller,
                //   onChanged: (otpCode) {
                //     // log(otpCode.length.toString());
                //     log(otpCode.length.toString());
                //     otpbloc.add(OTPCodeChanged(otpCode.length));
                //   },
                //   keyboardType: TextInputType.number,
                //   maxLength: 6,
                //   decoration: const InputDecoration(
                //     hintText: 'Enter OTP',
                //   ),
                // ),
              ),
              const Gap(20),
              BlocBuilder<OTPBloc, OTPState>(
                builder: (context, state) {
                  return Buttons().customButton(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OTPDialog(
                          otp: code,
                          mobileNumber: mobileNumber,
                        );
                      },
                    );
                  },
                      const Text(
                        'Verify',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      state is OTPValid ? Colors.blue : Colors.grey);
                },
              )
            ],
          ),
        ));
  }
}

class OTPDialog extends StatelessWidget {
  final String mobileNumber;
  final String otp;
  const OTPDialog({super.key, required this.mobileNumber, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          height: 250,
          width: 200,
          color: Colors.grey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mobile number',
                style: TextStyle(fontSize: 30),
              ),
              Gap(10),
              Text(
                mobileNumber,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Gap(20),
              Text(
                'OTP',
                style: TextStyle(fontSize: 30),
              ),
              Gap(10),
              Text(
                otp,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Gap(10),
              Buttons().customButton(() {
                Navigator.pop(context);
                Navigator.pop(context);
              }, Text('Back'), Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
