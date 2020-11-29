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
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Find my ",
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()..color = Colors.white,
                )),
            Text("pet",
                style: TextStyle(
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
            icon: Icon(Icons.send),
            onPressed: () {},
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<DogBreedBloc>(
            create: (context) {
              return DogBreedBloc(
                dogBreedRepository: DogBreedRepository(),
              )..add(LoadDogBreeds());
            },
          )
        ],
        child:
            BlocBuilder<DogBreedBloc, DogBreedState>(builder: (context, state) {
          if (state is DogBreedLoadSuccess) {
            return Container(
              color: Color(0xFF2741F9),
              child: Stack(children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Animales perdidos", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..color = Color(0xFF2741F9),
                        )),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left:32, right: 32),
                        child: buildDogBreedList(state),
                      ))
                    ],
                  ),
                    margin: EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30)))
                )
              ]),
            );
          } else {
            //TODO: handle loading
            return Container();
          }
        }),
      ),
    );
  }

  ListView buildDogBreedList(DogBreedLoadSuccess state) {
    return ListView.builder(
        itemCount: state.dogBreeds.length,
        itemBuilder: (context, index) {
          return buildDogBreedItem(state, index);
        });
  }

  Widget buildDogBreedItem(DogBreedLoadSuccess state, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 125, height: 150,child: Image.network(state.dogBreeds[index].image, fit: BoxFit.cover)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(child: Icon(Icons.favorite_border), alignment: Alignment.topRight),
                  Align(child: Text(state.dogBreeds[index].name, style: TextStyle(fontWeight: FontWeight.bold),), alignment: Alignment.topLeft,),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
