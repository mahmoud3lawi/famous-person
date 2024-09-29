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