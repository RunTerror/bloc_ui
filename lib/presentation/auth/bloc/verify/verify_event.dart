abstract class OTPEvent {}

class OTPCodeChanged extends OTPEvent {
  final int length;

  OTPCodeChanged(this.length);
}

class OTPVerified extends OTPEvent {}
