import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/ui/cubit/cart_screen_cubit.dart';
import 'package:urunler_app/ui/cubit/detail_screen_cubit.dart';
import 'package:urunler_app/ui/cubit/home_screen_cubit.dart';
import 'package:urunler_app/ui/screens/first_screen.dart';
import 'package:urunler_app/ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartScreenCubit()),
        BlocProvider(create: (context) => DetailScreenCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
      ],
      child: MaterialApp(
        title: 'Ürünler Uygulaması',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
          useMaterial3: true,
        ),
        home: const FirstScreen(),
      ),
    );
  }
}
