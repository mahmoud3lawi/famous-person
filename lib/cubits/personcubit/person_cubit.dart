import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/cubits/personcubit/person_state.dart';
import 'package:traning_project/services/api_service.dart';

class PersonCubit extends Cubit<PersonState> {
  final ApiService apiService;

  PersonCubit(this.apiService) : super(PersonLoading());

  Future<void> fetchFamousPersons() async {
    try {
      emit(PersonLoading());
      final famousPersons = await apiService.getFamousPersons();
      emit(PersonLoaded(famousPersons));
    } catch (e) {
      emit(PersonError(e.toString()));
    }
  }
}
