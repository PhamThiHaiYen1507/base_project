import 'package:json_annotation/json_annotation.dart';

part 'project_from_thirdparty_model.g.dart';

@JsonSerializable()
class ProjectFromThirdPartyModel {
  final String name;
  final String url;
  final String status;
  final String owner;

  factory ProjectFromThirdPartyModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromThirdPartyModelFromJson(json);

  ProjectFromThirdPartyModel(this.name, this.url, this.status, this.owner);

  Map<String, dynamic> toJson() => _$ProjectFromThirdPartyModelToJson(this);
}
