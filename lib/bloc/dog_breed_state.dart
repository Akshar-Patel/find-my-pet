import 'package:equatable/equatable.dart';
import 'package:find_my_pet/model/dog_breed.dart';

abstract class DogBreedListState extends Equatable {
  const DogBreedListState();

  @override
  List<Object> get props => [];
}

class DogBreedListLoadInProgress extends DogBreedListState {}

class DogBreedListLoadSuccess extends DogBreedListState {
  final List<DogBreed> dogBreeds;

  const DogBreedListLoadSuccess([this.dogBreeds = const []]);

  @override
  List<Object> get props => [dogBreeds];
}

class DogBreedListLoadFailure extends DogBreedListState {}