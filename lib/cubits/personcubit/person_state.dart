import 'package:traning_project/models/person_model.dart';

class PersonState {}

class PersonLoading extends PersonState {}

class PersonLoaded extends PersonState {
  final List<PersonModel> famousPersons;
  PersonLoaded(this.famousPersons);
}

class PersonError extends PersonState {
  final String error;
  PersonError(this.error);
}