import 'package:basic_utils/basic_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DogEntity extends Equatable {
  final String image;
  final String name;

  DogEntity(this.image, this.name);

  @override
  List<Object> get props => [image,name];

  Map<String, Object> toJson() {
    return {
      'image': image
    };
  }
  static DogEntity fromJson(String image) {
    return DogEntity(image, extractName(image));
  }

  static String extractName(String image) {
    String name = image.split("/")[4].replaceAll("-", " ");
    name = StringUtils.capitalize(name, allWords: true);
    return name;
  }
}
