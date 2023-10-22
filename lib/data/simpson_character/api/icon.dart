import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'icon.g.dart';

@JsonSerializable()
class Icon extends Equatable {
  @JsonKey(name: 'Height')
  final String? height;
  @JsonKey(name: 'URL')
  final String? url;
  @JsonKey(name: 'Width')
  final String? width;

  const Icon({this.height, this.url, this.width});

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);

  Map<String, dynamic> toJson() => _$IconToJson(this);

  Icon copyWith({
    String? height,
    String? url,
    String? width,
  }) {
    return Icon(
      height: height ?? this.height,
      url: url ?? this.url,
      width: width ?? this.width,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [height, url, width];
}
