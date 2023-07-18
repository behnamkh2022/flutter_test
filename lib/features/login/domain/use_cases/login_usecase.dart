import 'package:samim/core/resources/data_state.dart';
import 'package:samim/core/usecase/use_case.dart';
import 'package:samim/features/login/domain/entities/user_entity.dart';
import 'package:samim/features/login/domain/repository/login_repository.dart';

class GetLoginUseCase extends UseCase<DataState<List<UserEntity>>, Object> {
  final UserRepository loginBaseRepository;

  GetLoginUseCase(this.loginBaseRepository);

  @override
  Future<DataState<List<UserEntity>>> call(Object params) {
    Map<String, dynamic> paramMap = params as Map<String, dynamic>;
    String email = paramMap['email'];
    String password = paramMap['password'];
    return loginBaseRepository.getUsers({email, password});
  }
}
