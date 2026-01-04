import 'package:bexel/Core/Extentions/padding_ext.dart';
import 'package:bexel/Core/Helper/input_validator.dart';
import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/Core/Widget/custom_text_form_field.dart';
import 'package:bexel/Core/Widget/main_app_button.dart';
import 'package:bexel/Feature/authentication/Presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Constant/assets_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var authCubit = AuthCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: authCubit.formKey,
                child:
                    ListView(
                      children: [
                        Center(
                          child: Image.asset(
                            AssetsStrings.appLogo,
                            width: size.width * 0.5,
                            height: size.height * 0.2,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text('Welcome to Login Screen'),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          controller: authCubit.emailController,
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.iconPrimary,
                          ),
                          hintText: 'Email',
                          validator: (value) =>
                              InputValidator.validateEmail(value!),
                        ),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: authCubit.passwordController,
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppColors.iconPrimary,
                          ),
                          hintText: 'Password',
                          obscureText: !authCubit.isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              authCubit.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.iconPrimary,
                            ),
                            onPressed: () {
                              authCubit.togglePasswordVisibility();
                            },
                          ),
                          validator: (value) =>
                              InputValidator.validateNotEmpty(value!),
                        ),
                        const SizedBox(height: 30),
                        MainAppButton(
                          bgColor: AppColors.primary500,
                          height: 55,
                          child: Text(
                            'Login',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.natural100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            authCubit.loginUser();
                          },
                        ),
                      ],
                    ).setHorizontalAndVerticalPadding(
                      context,
                      15,
                      20,
                      enableMediaQuery: false,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
