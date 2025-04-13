

abstract class UserState {}

class UserInitial extends UserState {}

class SignInLoading extends UserState {}
class SignInSuccess extends UserState {
  final String token;
  SignInSuccess(this.token);
}
class SignInFailure extends UserState {
  final String errMessage;
  SignInFailure(this.errMessage);
}

class SignUpLoading extends UserState {}
class SignUpSuccess extends UserState {
  final String token;
  SignUpSuccess(this.token);
}
class SignUpFailure extends UserState {
  final String errMessage;
  SignUpFailure(this.errMessage);
}
