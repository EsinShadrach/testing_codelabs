import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelabs/models/favourites.dart';
import 'package:testing_codelabs/screens/favourite.dart';
import 'package:testing_codelabs/screens/home.dart';

void main() {
  runApp(const TestingApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: FavouriteScreen.routeName,
          builder: (context, state) {
            return const FavouriteScreen();
          },
        ),
      ],
    ),
  ],
);

class TestingApp extends StatelessWidget {
  const TestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favourite>(
      create: (context) => Favourite(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Testing App",
        routerConfig: _router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
      ),
    );
  }
}
