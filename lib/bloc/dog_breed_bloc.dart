import 'dart:async';

import 'package:find_my_pet/repository/dog_breed_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'dog_breed_event.dart';
import 'dog_breed_state.dart';

class DogBreedBloc extends Bloc<DogBreedEvent, DogBreedState> {
  final DogBreedRepository dogBreedRepository;
  StreamSubscription _dogBreedSubscription;

  DogBreedBloc({@required this.dogBreedRepository})
      : super(DogBreedLoadInProgress());

  @override
  Stream<DogBreedState> mapEventToState(DogBreedEvent event) async* {
    if (event is LoadDogBreeds) {
      yield* _mapLoadTransactionState();
    }
    if (event is UpdateDogBreed) {
      yield* _mapUpdateTransactionState(event);
    }
  }

  Stream<DogBreedState> _mapLoadTransactionState() async* {
    _dogBreedSubscription?.cancel();
    _dogBreedSubscription = dogBreedRepository.loadTransactions().listen(
          (todos) => add(UpdateDogBreed(todos)),
        );
  }

  Stream<DogBreedState> _mapUpdateTransactionState(
      UpdateDogBreed event) async* {
    yield DogBreedLoadSuccess(event.dogBreedList);
  }

  @override
  Future<void> close() {
    _dogBreedSubscription?.cancel();
    return super.close();
  }
}
