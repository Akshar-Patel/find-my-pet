import 'package:find_my_pet/api/api_client.dart';
import 'package:find_my_pet/bloc/dog_breed_bloc.dart';
import 'package:find_my_pet/bloc/dog_breed_event.dart';
import 'package:find_my_pet/bloc/dog_breed_state.dart';
import 'package:find_my_pet/dog_breed_detail.dart';
import 'package:find_my_pet/dog_breed_detail_arguments.dart';
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

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
            key: _navigatorKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              // Manage your route names here
              switch (settings.name) {
                case '/':
                  builder = (BuildContext context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<DogBreedBloc>(
                        create: (context) {
                          return DogBreedBloc(
                            dogBreedRepository: DogBreedRepository(),
                          )..add(LoadDogBreeds());
                        },
                      )
                    ],
                    child: BlocBuilder<DogBreedBloc, DogBreedState>(
                        builder: (context, state) {
                          if (state is DogBreedLoadSuccess) {
                            return Container(
                              color: Color(0xFF2741F9),
                              child: Stack(children: [
                                Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text("Animales perdidos",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                foreground: Paint()
                                                  ..color = Color(0xFF2741F9),
                                              )),
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 32, right: 32),
                                              child: buildDogBreedList(state),
                                            ))
                                      ],
                                    ),
                                    margin: EdgeInsets.only(top: 120),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        )))
                              ,
                                Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: AppBar(
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
                                )]),
                            );
                          } else {
                            //TODO: handle loading
                            return Container();
                          }
                        }),
                  );
                  break;
                case '/page1':
                  builder = (BuildContext context) => DogBreedDetailScreen();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              // You can also return a PageRouteBuilder and
              // define custom transitions between pages
              return MaterialPageRoute(
                builder: builder,
                settings: settings,
              );
            }
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
        );
  }

  static BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Search',
        )
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: null,
    );
  }

  ListView buildDogBreedList(DogBreedLoadSuccess state) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0),
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
          child: InkWell(
            splashColor: Colors.grey.withAlpha(30),
            onTap: () {
              _navigatorKey.currentState.pushNamed('/page1',
                  arguments: DogBreedDetailArguments(state.dogBreeds[index].name, state.dogBreeds[index].image));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 125,
                    height: 200,
                    child:
                    FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "assets/loading.gif",
                      image: state.dogBreeds[index].image,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                            child: Icon(Icons.favorite_border, size: 16,),
                            alignment: Alignment.topRight),
                        Align(
                          child: Text(
                            state.dogBreeds[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Ubicacion: ${state.dogBreeds[index].location}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700
                                ),)),
                        ),
                        Text(state.dogBreeds[index].description)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
