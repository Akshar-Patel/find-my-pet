import 'package:equatable/equatable.dart';

class DogEntity extends Equatable {
  final String image;

  DogEntity(this.image);

  @override
  List<Object> get props => [image];

  Map<String, Object> toJson() {
    return {
      'image': image
    };
  }
  static DogEntity fromJson(String image) {
    return DogEntity(image);
  }
}
