import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simpsons_demo/data/simpson_character/api/base_model.dart';

import 'icon.dart';

part 'related_topic.g.dart';

@JsonSerializable()
class RelatedTopic extends BaseModel with EquatableMixin {
  @JsonKey(name: 'FirstURL')
  final String? firstUrl;
  @JsonKey(name: 'Icon')
  final Icon? icon;
  @JsonKey(name: 'Result')
  final String? result;
  @JsonKey(name: 'Text')
  final String? text;

  RelatedTopic({this.firstUrl, this.icon, this.result, this.text});

  factory RelatedTopic.fromJson(Map<String, dynamic> json) {
    return _$RelatedTopicFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RelatedTopicToJson(this);

  RelatedTopic copyWith({
    String? firstUrl,
    Icon? icon,
    String? result,
    String? text,
  }) {
    return RelatedTopic(
      firstUrl: firstUrl ?? this.firstUrl,
      icon: icon ?? this.icon,
      result: result ?? this.result,
      text: text ?? this.text,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [firstUrl, icon, result, text];
}
