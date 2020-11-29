import 'package:equatable/equatable.dart';
import 'package:find_my_pet/model/dog_breed.dart';


abstract class DogBreedEvent extends Equatable {
  const DogBreedEvent();

  @override
  List<Object> get props => [];
}

class LoadDogBreeds extends DogBreedEvent {}

class UpdateDogBreed extends DogBreedEvent {
  final List<DogBreed> dogBreedList;

  const UpdateDogBreed(this.dogBreedList);

  @override
  List<Object> get props => [dogBreedList];
}

class FailedDogBreeds extends DogBreedEvent {}