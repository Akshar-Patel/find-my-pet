import 'package:find_my_pet/dog_breed_detail_arguments.dart';
import 'package:flutter/material.dart';

class DogBreedDetailScreen extends StatefulWidget {
  DogBreedDetailScreen({Key key}) : super(key: key);

  @override
  _DogBreedDetailScreenState createState() => _DogBreedDetailScreenState();
}

class _DogBreedDetailScreenState extends State<DogBreedDetailScreen> {
  @override
  Widget build(BuildContext context) {

    final DogBreedDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Scaffold(
            // No appbar provided to the Scaffold, only a body with a
            // CustomScrollView.
            body: 
        Stack(
          children: [
            
            Container(
              height: 500,
              child: Image.network(args.image,
                fit: BoxFit.fitHeight,),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
              height: 400,
              child: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed button this many times:',
                      ),
                    ],
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
                    width: 300,
                    height: 50,
                    
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          Positioned( //Place it at the top, and not use the entire screen
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
            title:  
          Padding(
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
          ),),
          ],
        ),)

        );
  }
}
