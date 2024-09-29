import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/cubits/personcubit/person_cubit.dart';
import 'package:traning_project/screens/famous_person.dart';
import 'package:traning_project/services/api_service.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PersonCubit>(
          create: (context) => PersonCubit(ApiService()),
        ),
      ],
      child:  Training(),
    ),
  );
}


class Training extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FamousPerson(),
      debugShowCheckedModeBanner: false, 
    );
  }
}
