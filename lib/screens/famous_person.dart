import 'package:flutter/material.dart';
import 'package:traning_project/constant.dart';
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
  List<PersonModel> famousPersons = [];
  List<PersonModel> favoritePersons = [];

  @override
  void initState() {
    super.initState();
    _getFamousPersons();
  }

  Future<void> _getFamousPersons() async {
    ApiService apiService = ApiService();
    List<PersonModel> persons = await apiService.getFamousPersons();
    setState(() {
      famousPersons = persons;
    });
  }

  void _toggleFavorite(PersonModel person) {
    setState(() {
      if (favoritePersons.contains(person)) {
        favoritePersons.remove(person);
      } else {
        favoritePersons.add(person);
      }
    });
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
            onPressed: () async {
              // Navigate to the favorite screen and wait for a result
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(favoritePersons: favoritePersons),
                ),
              );
              // Rebuild to reflect any changes in the favoritePersons list
              setState(() {});
            },
          ),
        ],
      ),
      body: famousPersons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.5,
              ),
              itemCount: famousPersons.length,
              itemBuilder: (context, index) {
                PersonModel person = famousPersons[index];
                bool isFavorite = favoritePersons.contains(person);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(personId: person.id),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: KBackGroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            person.image ?? 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset('assets/placeholder.png'),
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
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : kPrimaryColor,
                                ),
                                onPressed: () {
                                  _toggleFavorite(person);
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
            ),
    );
  }
}
