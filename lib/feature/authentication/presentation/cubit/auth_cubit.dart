import 'package:bexel/Core/Helper/dependency_injection_helper.dart';
import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/Core/Widget/custom_snack_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Core/Data/app_database.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // varables
  final DependencyInjectionHelper di = DependencyInjectionHelper();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginUser() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        var user = await di.sl<AppDatabase>().getUserByEmailandPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.dismiss();
        });
        if (user.email == emailController.text &&
            user.password == passwordController.text) {
          showCustomSnackBar(
            message: 'Login Successful',
            backgroundColor: AppColors.primary500,
          );
        } else {
          showCustomSnackBar(
            message: 'Invalid email or password',
            backgroundColor: AppColors.darkRed,
          );
        }
      } catch (e) {
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.dismiss();
        });
        showCustomSnackBar(
          message: 'Invalid email or password',
          backgroundColor: AppColors.darkRed,
        );
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityState(isPasswordVisible: isPasswordVisible));
  }
}
