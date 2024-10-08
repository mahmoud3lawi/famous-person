import 'package:flutter/material.dart';
import 'package:traning_project/constant.dart';
import 'package:traning_project/models/person_model.dart';
import 'package:traning_project/screens/details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  final List<PersonModel> favoritePersons;

  const FavoriteScreen({super.key, required this.favoritePersons});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<PersonModel> favoritePersons;

  @override
  void initState() {
    super.initState();
    favoritePersons = widget.favoritePersons;
  }

  void _removeFavorite(PersonModel person) {
    setState(() {
      favoritePersons.remove(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite People',
          style: TextStyle(
            fontFamily: 'Sofadi One',
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: KBackGroundColor,
      ),
      body: favoritePersons.isEmpty
          ? const Center(
              child: Text(
                'No favorite people added.',
                style: TextStyle(
                  fontFamily: 'Sofadi One',
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoritePersons.length,
              itemBuilder: (context, index) {
                PersonModel person = favoritePersons[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), 
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        person.image ?? 'https://via.placeholder.com/50',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/placeholder.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      person.name ?? 'Unknown',
                      style: const TextStyle(
                        fontFamily: 'Sofadi One',
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        _removeFavorite(person);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(personId: person.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
