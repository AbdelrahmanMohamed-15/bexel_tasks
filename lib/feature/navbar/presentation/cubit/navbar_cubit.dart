import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Routes/bloc_providers.dart';
import '../../../profile/presentation/views/profile_screen.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  static NavbarCubit get(context) => BlocProvider.of(context);

  // variables
  int currentIndex = 0;
  PageController pageController = PageController();
  var screens = [BlocProviders.homeProvider, const ProfileScreen()];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavbarState(index: index));
    pageController.jumpToPage(index);
  }
}
