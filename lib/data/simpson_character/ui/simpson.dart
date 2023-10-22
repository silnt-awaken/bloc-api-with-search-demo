import 'package:simpsons_demo/data/simpson_character/api/related_topic.dart';
import 'package:simpsons_demo/data/ui_model.dart';
import 'package:simpsons_demo/util/string_customizations.dart';

class Simpson extends UIModel {
  Simpson(
      {required super.title, required super.description, required super.image});

  factory Simpson.fromRelatedTopic(RelatedTopic relatedTopic) {
    return Simpson(
      title: relatedTopic.text?.extractName ?? 'No Name',
      image: relatedTopic.icon?.url ?? 'No Image',
      description: relatedTopic.text?.extractDescription ?? 'No Description',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Simpson &&
        other.title == title &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ image.hashCode;
}
