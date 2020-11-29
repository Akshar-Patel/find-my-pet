import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DogEntity extends Equatable {
  final String image;
  final String name;
  final String description;
  final String location;

  DogEntity(this.image, this.name, this.description, this.location);

  @override
  List<Object> get props => [image, name, description];

  static DogEntity fromJson(String image) {
    return DogEntity(image, extractName(image), dummyDescription(), randomLocation());
  }

  static String extractName(String image) {
    String name = image.split("/")[4].replaceAll("-", " ");
    name = StringUtils.capitalize(name, allWords: true);
    return name;
  }

  static String dummyDescription() {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed viverra urna, in fermentum urna.";
  }

  static String randomLocation() {
    var list = ['Pocitos','Prado','Punto Garda','Batlle','Rodo'];
    final _random = new Random();
    var element = list[_random.nextInt(list.length)];
    return element;
  }
}
