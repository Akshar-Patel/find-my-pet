
import '../api/api_client.dart';
import '../model/dog_breed.dart';

class DogBreedRepository{

  ApiClient apiClient;

  DogBreedRepository(){
    this.apiClient = ApiClient();
  }

  Stream<List<DogBreed>> loadTransactions() async* {
    yield* apiClient.fetchDogBreeds();
  }
}