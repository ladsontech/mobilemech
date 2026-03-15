import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String phone;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
