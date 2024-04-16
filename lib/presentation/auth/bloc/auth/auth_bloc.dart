import 'package:assignment/presentation/auth/bloc/auth/auth_event.dart';
import 'package:assignment/presentation/auth/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<TextChangeEvent>((event, emit) {
      if (event.lenght == 10) {
        emit(AuthValidState());
      } else {
        emit(AuthErrorState(
            errorMessage: 'Please enter a 10 digit mobile number'));
      }
    });

    on<AuthSubmittedEvent>((event, emit) async {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthValidState());
    });
  }
}
