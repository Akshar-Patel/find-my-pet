import 'package:find_my_pet/entity/dog_entity.dart';
import 'package:meta/meta.dart';

@immutable
class DogBreed {

  final String image;

  DogBreed(this.image);

  DogEntity toEntity() {
    return DogEntity(image);
    }

  static DogBreed fromEntity(DogEntity entity) {
    return DogBreed(entity.image);
  }
}