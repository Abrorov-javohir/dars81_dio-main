import 'package:dars81_dio/bloc/users/users_bloc.dart';
import 'package:dars81_dio/data/repositories/users_repository.dart';
import 'package:dars81_dio/ui/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) {
        return UsersRepository();
      },
      child: BlocProvider(
        create: (context) {
          return UsersBloc(
            usersRepository: context.read<UsersRepository>(),
          );
        },
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsScreen(), // Adjusted screen name to match the import
    );
  }
}
