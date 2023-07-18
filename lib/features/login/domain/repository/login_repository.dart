import 'package:samim/core/resources/data_state.dart';
import 'package:samim/features/login/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers(Object params);
}
