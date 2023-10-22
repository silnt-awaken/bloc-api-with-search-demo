// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wire_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WireCharacter _$WireCharacterFromJson(Map<String, dynamic> json) =>
    WireCharacter(
      relatedTopics: (json['RelatedTopics'] as List<dynamic>?)
          ?.map((e) => RelatedTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WireCharacterToJson(WireCharacter instance) =>
    <String, dynamic>{
      'RelatedTopics': instance.relatedTopics,
    };
