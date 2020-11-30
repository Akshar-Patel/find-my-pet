import 'package:find_my_pet/dog_breed_detail_arguments.dart';
import 'package:flutter/material.dart';

import 'constants.dart' as Constants;

class DogBreedDetailScreen extends StatefulWidget {
  DogBreedDetailScreen({Key key}) : super(key: key);

  @override
  _DogBreedDetailScreenState createState() => _DogBreedDetailScreenState();
}

class _DogBreedDetailScreenState extends State<DogBreedDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final DogBreedDetailArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: args.image,
                child: Image.network(
                  args.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 400),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 400,
              child: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Container(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 42),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Constants.primaryColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Sexo",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text("Macho")
                                    ],
                                  )),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1),
                            Align(
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Constants.primaryColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Color",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text("Marron")
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 32),
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ubicacion: "+ args.location,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    args.description,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: ButtonTheme(
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              child: RaisedButton(
                          child: Text("Contactar", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                          color: Constants.primaryColor,
                          textColor: Colors.white,
                          onPressed: (){},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.only(top: 375),
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    color: Colors.white,
                    child: Text(
                      args.name,
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              //Place it at the top, and not use the entire screen
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                leading: BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 48.0),
                  child: Row(
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
                ),
                backgroundColor: Colors.transparent, //No more green
                elevation: 0.0, //Shadow gone
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
