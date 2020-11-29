import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/dog_breed.dart';
import '../entity/dog_entity.dart';

class ApiClient {
  String baseUrl;
  final http.Client httpClient;

  ApiClient({
    http.Client httpClient,
    this.baseUrl = "https://dog.ceo/api/breeds/image/random/5",
  }) : this.httpClient = httpClient ?? http.Client();

  Stream<List<DogBreed>> fetchDogBreeds() async* {
    final response = await httpClient.get(Uri.parse("$baseUrl"));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> results = map["message"];
    yield results
         .map((dynamic item) => DogBreed.fromEntity(
         DogEntity.fromJson(item as String)))
         .toList();
  }
}
