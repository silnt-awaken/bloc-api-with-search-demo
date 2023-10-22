import 'package:simpsons_demo/data/wire_character/api/related_topic.dart';
import 'package:simpsons_demo/util/string_customizations.dart';

import '../../ui_model.dart';

class Wire extends UIModel {
  Wire({
    required super.title,
    required super.description,
    required super.image,
  });

  factory Wire.fromRelatedTopic(RelatedTopic relatedTopic) {
    return Wire(
      title: relatedTopic.text?.extractName ?? 'No Name',
      image: relatedTopic.icon?.url ?? 'No Image',
      description: relatedTopic.text?.extractDescription ?? 'No Description',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wire &&
        other.title == title &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ image.hashCode;
}
