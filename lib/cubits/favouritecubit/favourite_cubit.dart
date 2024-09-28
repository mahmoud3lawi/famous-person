import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/models/person_model.dart';

class FavoriteCubit extends Cubit<List<PersonModel>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(PersonModel person) {
    if (state.contains(person)) {
      emit(state.where((p) => p != person).toList());
    } else {
      emit([...state, person]);
    }
  }
}
