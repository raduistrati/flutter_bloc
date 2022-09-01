import 'package:bloc_architecture_test/src/blocs/movie_detail_bloc_provider.dart';
import 'package:bloc_architecture_test/src/blocs/movies_bloc.dart';
import 'package:bloc_architecture_test/src/ui/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:bloc_architecture_test/src/models/item_model.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMoovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GridView buildList(AsyncSnapshot<ItemModel> snapshot) {
    const _endpoint = 'https://image.tmdb.org/t/p/w185';
    return GridView.builder(
        itemCount: snapshot.data!.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                _endpoint + snapshot.data!.results[index].poster_path,
                fit: BoxFit.cover,
              ),
              onTap: () => _openDetialPage(snapshot.data!, index),
            ),
          );
        });
  }

  void _openDetialPage(ItemModel data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final _selectedModel = data.results[index];
      return MovieDetailBlocProvider(
        child: MovieDetail(
            title: _selectedModel.title,
            posterUrl: _selectedModel.backdrop_path,
            description: _selectedModel.overview,
            releaseDate: _selectedModel.release_date,
            voteAverage: _selectedModel.vote_average.toString(),
            movieId: _selectedModel.id),
      );
    }));
  }
}
