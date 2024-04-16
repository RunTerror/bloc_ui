import 'package:assignment/presentation/auth/bloc/verify/verify_event.dart';
import 'package:assignment/presentation/auth/bloc/verify/verify_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPBloc() : super(OTPInitial()) {
    on<OTPCodeChanged>((event, emit) {
      if (event.length == 6) {
        emit(OTPValid());
      } else {
        emit(OTPInitial());
      }
    });
    on<OTPVerified>((event, emit) {});
  }
}
