import 'package:equatable/equatable.dart';
import 'package:find_my_pet/model/dog_breed.dart';

abstract class DogBreedState extends Equatable {
  const DogBreedState();

  @override
  List<Object> get props => [];
}

class DogBreedLoadInProgress extends DogBreedState {}

class DogBreedLoadSuccess extends DogBreedState {
  final List<DogBreed> dogBreeds;

  const DogBreedLoadSuccess([this.dogBreeds = const []]);

  @override
  List<Object> get props => [dogBreeds];
}

class DogBreedsLoadFailure extends DogBreedState {}