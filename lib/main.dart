import 'package:find_my_pet/api/api_client.dart';
import 'package:find_my_pet/bloc/dog_breed_bloc.dart';
import 'package:find_my_pet/bloc/dog_breed_event.dart';
import 'package:find_my_pet/bloc/dog_breed_state.dart';
import 'package:find_my_pet/repository/dog_breed_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(FindMyPetApp());
}

class FindMyPetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find My Pet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Find My Pet"),
      ),
      body: MultiBlocProvider(
        providers:[
          BlocProvider<DogBreedBloc>(
            create: (context) {
              return DogBreedBloc(
                dogBreedRepository: DogBreedRepository(),
              )..add(LoadDogBreeds());
            },
          )
        ],
        child: BlocBuilder<DogBreedBloc, DogBreedState>(
          builder: (context, state){
            if(state is DogBreedLoadSuccess){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.dogBreeds.first.image),
                  ],
                ),
              );
            }else {
              return Container();
            }
          }
        ),
      ),
    );
  }
}
