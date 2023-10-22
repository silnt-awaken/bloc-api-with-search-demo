import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'related_topic.dart';

part 'simpson_character.g.dart';

@JsonSerializable()
class SimpsonCharacter extends Equatable {
  @JsonKey(name: 'RelatedTopics')
  final List<RelatedTopic>? relatedTopics;

  const SimpsonCharacter({
    this.relatedTopics,
  });

  factory SimpsonCharacter.fromJson(Map<String, dynamic> json) {
    return _$SimpsonCharacterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SimpsonCharacterToJson(this);

  SimpsonCharacter copyWith({
    List<RelatedTopic>? relatedTopics,
  }) {
    return SimpsonCharacter(
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
