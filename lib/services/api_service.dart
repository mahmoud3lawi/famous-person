import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:traning_project/models/person_model.dart';

class ApiService {
  String baseUrl = 'https://api.themoviedb.org/3/person';
  String apiKey = '2dfe23358236069710a379edd4c65a6b';

  Future<List<PersonModel>> getFamousPersons() async {
    Uri url = Uri.parse('$baseUrl/popular?api_key=$apiKey');
    http.Response response = await http.get(url);

    
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['results'];

      
      return results.map((person) => PersonModel.fromJson(person)).toList();
  }

  
  Future<List<dynamic>> getPersonImages(int personId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$baseUrl/$personId/images?api_key=$apiKey'));

      
        final data = jsonDecode(response.body);
        return data['profiles']; 
    } catch (e) {
      throw Exception('Error fetching images: $e');
    }
  }
  
  Future<Map<String, dynamic>> getPersonDetails(int personId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '$baseUrl/$personId?api_key=$apiKey'));
      
        return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error fetching person details: $e');
    }
  }
}
