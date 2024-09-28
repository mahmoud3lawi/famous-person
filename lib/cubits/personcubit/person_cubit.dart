import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/services/api_service.dart';
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

class PersonCubit extends Cubit<PersonState> {
  final ApiService apiService;

  PersonCubit(this.apiService) : super(PersonLoading());

  Future<void> getFamousPersons() async {
    try {
      emit(PersonLoading());
      final famousPersons = await apiService.getFamousPersons();
      emit(PersonLoaded(famousPersons));
    } catch (e) {
      emit(PersonError(e.toString()));
    }
  }
}
