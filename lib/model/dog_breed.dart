import 'package:find_my_pet/entity/dog_entity.dart';
import 'package:meta/meta.dart';

@immutable
class DogBreed {

  final String image;
  final String name;

  DogBreed(this.image, this.name);

  DogEntity toEntity() {
    return DogEntity(image, this.name);
    }

  static DogBreed fromEntity(DogEntity entity) {
    return DogBreed(entity.image, entity.name);
  }
}