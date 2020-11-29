
import '../api/api_client.dart';
import '../model/dog_breed.dart';

class DogBreedRepository{

  ApiClient apiClient;

  DogBreedRepository(){
    this.apiClient = ApiClient();
  }

  Stream<List<DogBreed>> loadDogBreeds() async* {
    yield* apiClient.fetchDogBreeds();
  }
}