import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_muhammed_ali/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../local_storage/shared_preferences_manager.dart';
import '../../network/dio_manager.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  DioManager dioManager = DioManager();

  LoginModel loginModel = LoginModel();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> userLogin() async {
    emit(LogInLoadingState());

    Either<String, LoginModel> loginEither = await dioManager.sendLoginAsync(
      username: userNameController.text,
      password: passwordController.text,
    );
    loginEither.fold((left) {
      emit(LogInErrorState());
      debugPrint("failed");
    }, (right) {
      loginModel = right;
      PrefsManager.saveData(key: "token", value: loginModel.access.toString());
      emit(LogInSuccessState());
    });
  }

  void tokenText() {
    if (JwtDecoder.isExpired(PrefsManager.getData(key: "token")) == false) {
      PrefsManager.removeData(key: "token");
    }
  }
}
