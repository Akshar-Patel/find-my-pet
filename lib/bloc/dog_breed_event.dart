import 'package:equatable/equatable.dart';
import 'package:find_my_pet/model/dog_breed.dart';


abstract class DogBreedListEvent extends Equatable {
  const DogBreedListEvent();

  @override
  List<Object> get props => [];
}

class LoadDogBreedList extends DogBreedListEvent {}

class UpdateDogBreedList extends DogBreedListEvent {
  final List<DogBreed> dogBreedList;

  const UpdateDogBreedList(this.dogBreedList);

  @override
  List<Object> get props => [dogBreedList];
}

class FailedToLoadDogBreedList extends DogBreedListEvent {}