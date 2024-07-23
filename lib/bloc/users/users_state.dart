part of 'users_bloc.dart';

abstract class UsersState {}

class InitialUsersState extends UsersState {}

class LoadingUsersState extends UsersState {}

class LoadedUsersState extends UsersState {
  final List<Product> users;

  LoadedUsersState(this.users);
}

class SuccessState extends UsersState {}

class ErrorUsersState extends UsersState {
  final String message;

  ErrorUsersState(this.message);
}
