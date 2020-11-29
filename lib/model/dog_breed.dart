import 'package:find_my_pet/entity/dog_entity.dart';
import 'package:meta/meta.dart';

@immutable
class DogBreed {

  final String image;
  final String name;
  final String description;
  final String location;

  DogBreed(this.image, this.name, this.description, this.location);

  DogEntity toEntity() {
    return DogEntity(image, this.name, this.description, this.location);
    }

  static DogBreed fromEntity(DogEntity entity) {
    return DogBreed(entity.image, entity.name, entity.description,entity.location);
  }
}