import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'related_topic.dart';

part 'wire_character.g.dart';

@JsonSerializable()
class WireCharacter extends Equatable {
  @JsonKey(name: 'RelatedTopics')
  final List<RelatedTopic>? relatedTopics;

  const WireCharacter({
    this.relatedTopics,
  });

  factory WireCharacter.fromJson(Map<String, dynamic> json) {
    return _$WireCharacterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WireCharacterToJson(this);

  WireCharacter copyWith({
    List<RelatedTopic>? relatedTopics,
  }) {
    return WireCharacter(
      relatedTopics: relatedTopics ?? this.relatedTopics,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      relatedTopics,
    ];
  }
}
