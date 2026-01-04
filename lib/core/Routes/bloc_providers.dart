//configuring a BlocProvider for a specific type of Bloc, along with its corresponding screen.

import 'package:bexel/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bexel/feature/home/presentation/views/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  // Instantiates ProfileBloc using its default constructor.
  static BlocProvider get homeProvider => BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(),
    child: const HomeScreen(),
  );
}
