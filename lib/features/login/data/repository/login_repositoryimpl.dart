import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:samim/core/resources/data_state.dart';
import 'package:samim/features/login/data/models/user_model.dart';
import 'package:samim/features/login/domain/entities/user_entity.dart';
import 'package:samim/features/login/domain/repository/login_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<DataState<List<UserEntity>>> getUsers(Object params) async {
    try {
      String jsonData = await rootBundle.loadString('assets/users.json');
      List<dynamic> jsonList = json.decode(jsonData);
      List<UserEntity> users =
          jsonList.map((json) => UserModel.fromJson(json)).toList();

      return DataSuccess(users);
    } catch (e) {
      return const DataFailed("please check your connection...");
    }
  }
}
