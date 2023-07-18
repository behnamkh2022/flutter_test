import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? username,
    String? email,
    String? state,
  }) : super(
          username: username,
          email: email,
          state: state,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      state: json['state'] as String,
    );
  }
}
