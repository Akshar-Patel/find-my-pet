import 'dart:async';

import 'package:find_my_pet/repository/dog_breed_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'dog_breed_event.dart';
import 'dog_breed_state.dart';

class DogBreedBloc extends Bloc<DogBreedListEvent, DogBreedListState> {
  final DogBreedRepository dogBreedRepository;
  StreamSubscription _dogBreedSubscription;

  DogBreedBloc({@required this.dogBreedRepository})
      : super(DogBreedListLoadInProgress());

  @override
  Stream<DogBreedListState> mapEventToState(DogBreedListEvent event) async* {
    if (event is LoadDogBreedList) {
      yield* _mapLoadDogBreedState();
    }
    if (event is UpdateDogBreedList) {
      yield* _mapUpdateDogBreedState(event);
    }
    if (event is FailedToLoadDogBreedList) {
      yield* _mapFailedDogBreedsState(event);
    }
  }

  Stream<DogBreedListState> _mapLoadDogBreedState() async* {
    _dogBreedSubscription?.cancel();
    _dogBreedSubscription = dogBreedRepository.loadDogBreeds().listen(
          (dogBreeds) {
            add(UpdateDogBreedList(dogBreeds));
          },
      onError:(Object error, StackTrace stackTrace){
            add(FailedToLoadDogBreedList());
      }
    );
  }

  Stream<DogBreedListState> _mapUpdateDogBreedState(
      UpdateDogBreedList event) async* {
    yield DogBreedListLoadSuccess(event.dogBreedList);
  }

  Stream<DogBreedListState> _mapFailedDogBreedsState(
      FailedToLoadDogBreedList event) async* {
    yield DogBreedListLoadFailure();
  }

  @override
  Future<void> close() {
    _dogBreedSubscription?.cancel();
    return super.close();
  }
}
