import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/services/api_service.dart';

class PersonDetailsState {}

class PersonDetailsLoading extends PersonDetailsState {}

class PersonDetailsLoaded extends PersonDetailsState {
  final Map<String, dynamic> personDetails;
  final List<dynamic> personImages;

  PersonDetailsLoaded(this.personDetails, this.personImages);
}

class PersonDetailsError extends PersonDetailsState {
  final String error;
  PersonDetailsError(this.error);
}

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  final ApiService apiService;

  PersonDetailsCubit(this.apiService) : super(PersonDetailsLoading());

  Future<void> fetchPersonDetails(int personId) async {
    try {
      emit(PersonDetailsLoading());
      final personDetails = await apiService.getPersonDetails(personId);
      final personImages = await apiService.getPersonImages(personId);
      emit(PersonDetailsLoaded(personDetails, personImages));
    } catch (e) {
      emit(PersonDetailsError(e.toString()));
    }
  }
}
