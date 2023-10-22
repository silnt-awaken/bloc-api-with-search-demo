// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simpson_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpsonCharacter _$SimpsonCharacterFromJson(Map<String, dynamic> json) =>
    SimpsonCharacter(
      relatedTopics: (json['RelatedTopics'] as List<dynamic>?)
          ?.map((e) => RelatedTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpsonCharacterToJson(SimpsonCharacter instance) =>
    <String, dynamic>{
      'RelatedTopics': instance.relatedTopics,
    };
