import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/cubits/detailscubit/details_state.dart';
import 'package:traning_project/services/api_service.dart';



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
