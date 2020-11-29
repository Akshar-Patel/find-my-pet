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
        primaryColor: Color(0xFF2741F9),
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
        leading: IconButton(
          icon: Icon(Icons.menu), onPressed: () {  },),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Find my ", style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..color = Colors.white,
            )),
            Text("pet", style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white,
            ))
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.send), onPressed: () {  },)
        ],
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
              return buildDogBreedList(state);
            }else {
              //TODO: handle loading
              return Container();
            }
          }
        ),
      ),
    );
  }

  ListView buildDogBreedList(DogBreedLoadSuccess state) {
    return ListView.builder(
                itemCount: state.dogBreeds.length,
                itemBuilder: (context, index) {
                  return buildDogBreedItem(
                      state, index);
                });
  }

  Widget buildDogBreedItem(DogBreedLoadSuccess state, int index) {
    return Text(state.dogBreeds[index].name);
  }
}
