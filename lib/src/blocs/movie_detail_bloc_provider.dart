import 'package:flutter/material.dart';
import 'movie_detail_bloc.dart';
export 'movie_detail_bloc.dart';


// TODO: - Implement provider method from flutter web example
// https://docs.flutter.dev/development/data-and-backend/state-mgmt/options#provider
// in order to reduce boilerplate code I can use provider framework

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key? key, required Widget child})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType()
    as MovieDetailBlocProvider).bloc;
  }
}

