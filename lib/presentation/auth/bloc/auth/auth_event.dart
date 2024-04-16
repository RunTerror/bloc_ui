abstract class AuthEvent {}

class TextChangeEvent extends AuthEvent {
  final int lenght;

  TextChangeEvent({required this.lenght});
}

class AuthSubmittedEvent extends AuthEvent {
  final String mobileNumber;
  final String fullPhoneNumber;

  AuthSubmittedEvent(
      {required this.mobileNumber, required this.fullPhoneNumber});
}
