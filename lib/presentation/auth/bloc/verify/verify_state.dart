// auth_state.dart

abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPValid extends OTPState {}

class OTPLoading extends OTPState {}
