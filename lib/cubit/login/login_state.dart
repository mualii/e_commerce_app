part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LogInLoadingState extends LoginState {}

class LogInSuccessState extends LoginState {}

class LogInErrorState extends LoginState {}

class ChangeState extends LoginState {}
