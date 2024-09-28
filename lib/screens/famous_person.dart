import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traning_project/constant.dart';
import 'package:traning_project/cubits/favouritecubit/favourite_cubit.dart';
import 'package:traning_project/cubits/personcubit/person_cubit.dart';
import 'package:traning_project/models/person_model.dart';
import 'package:traning_project/screens/details_screen.dart';
import 'package:traning_project/screens/favourite_screen.dart';
import 'package:traning_project/services/api_service.dart';

class FamousPerson extends StatefulWidget {
  const FamousPerson({super.key});

  @override
  _FamousPersonState createState() => _FamousPersonState();
}

class _FamousPersonState extends State<FamousPerson> {
  late PersonCubit _personCubit;

  @override
  void initState() {
    _personCubit = PersonCubit(ApiService())..getFamousPersons();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Famous People',
          style: TextStyle(
            fontFamily: 'Sofadi One',
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: KBackGroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: kPrimaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _personCubit,
        child: BlocBuilder<PersonCubit, PersonState>(
          builder: (context, state) {
            return state is PersonLoading
                ? const Center(child: CircularProgressIndicator())
                : state is PersonError
                    ? Center(
                        child: Text(
                          'Error: ${state.error}',
                          style: TextStyle(
                            fontFamily: 'Sofadi One',
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    : state is PersonLoaded
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.5,
                            ),
                            itemCount: state.famousPersons.length,
                            itemBuilder: (context, index) {
                              PersonModel person = state.famousPersons[index];
                              return BlocBuilder<FavoriteCubit,
                                  List<PersonModel>>(
                                builder: (context, favoritePersons) {
                                  bool isFavorite =
                                      favoritePersons.contains(person);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                              personId: person.id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: KBackGroundColor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              person.image ??
                                                  'https://via.placeholder.com/150',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      'assets/placeholder.png'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  person.name ?? 'Unknown',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: 'Sofadi One',
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    isFavorite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: isFavorite
                                                        ? Colors.red
                                                        : kPrimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<FavoriteCubit>()
                                                        .toggleFavorite(person);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Container();
          },
        ),
      ),
    );
  }
}
