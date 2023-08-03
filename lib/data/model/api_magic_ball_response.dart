import 'package:json_annotation/json_annotation.dart';

part 'api_magic_ball_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiMagicBallResponse {
  @JsonKey(name: 'reading')
  final String? reading;

  ApiMagicBallResponse(
    this.reading,
  );

  factory ApiMagicBallResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ApiMagicBallResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMagicBallResponseToJson(this);
}
