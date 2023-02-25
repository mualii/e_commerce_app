import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/dio_manager.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  DioManager dioManager = DioManager();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();

  Future<void> userRegister() async {
    emit(RegisterLoadingState());

    bool hideText = true;
    String? massege;
    Either<String, String> registerEither = await dioManager.sendRegisterAsync(
      username: userNameController.text,
      password: passwordController.text,
      email: '',
      first_name: '',
      last_name: '',
    );
    registerEither.fold((left) {
      massege = left;
      emit(RegisterErrorState());
      debugPrint("failed");
    }, (right) {
      massege = right;
      emit(RegisterSuccessState());
    });
  }
}
