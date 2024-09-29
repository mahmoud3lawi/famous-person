import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/constant.dart';
import 'package:traning_project/cubits/detailscubit/details_cubit.dart';
import 'package:traning_project/cubits/detailscubit/details_state.dart';
import 'package:traning_project/services/api_service.dart';
import 'package:traning_project/screens/image_screen.dart';

class DetailsScreen extends StatefulWidget {
  final int personId;

  const DetailsScreen({super.key, required this.personId});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late PersonDetailsCubit _personDetailsCubit;

  @override
  void initState() {
    _personDetailsCubit = PersonDetailsCubit(ApiService());
    _personDetailsCubit.fetchPersonDetails(widget.personId);
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Person Details',
          style: TextStyle(
            fontFamily: 'Sofadi One',
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: KBackGroundColor,
      ),
      body: BlocProvider(
        create: (context) => _personDetailsCubit,
        child: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
          builder: (context, state) {
            return state is PersonDetailsLoading
                ? Center(child: CircularProgressIndicator())
                : state is PersonDetailsError
                    ? Center(
                        child: Text(
                          'Error: ${state.error}',
                          style: TextStyle(
                            fontFamily: 'Sofadi One',
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    : state is PersonDetailsLoaded
                        ? Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.personDetails['name'] ??
                                              'Unknown',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Known for: ${state.personDetails['known_for_department'] ?? 'N/A'}',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Birthday: ${state.personDetails['birthday'] ?? 'N/A'}',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Place of birth: ${state.personDetails['place_of_birth'] ?? 'N/A'}',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          state.personDetails['biography'] ??
                                              'Biography not available',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            fontSize: 14,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: state.personImages.isEmpty
                                    ? Center(
                                        child: Text(
                                          'No images available',
                                          style: TextStyle(
                                            fontFamily: 'Sofadi One',
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      )
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.7,
                                        ),
                                        itemCount: state.personImages.length,
                                        itemBuilder: (context, index) {
                                          String imageUrl =
                                              'https://image.tmdb.org/t/p/w500' +
                                                  state.personImages[index]
                                                      ['file_path'];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageScreen(
                                                          imageUrl: imageUrl),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          )
                        : Container();
          },
        ),
      ),
    );
  }
}
