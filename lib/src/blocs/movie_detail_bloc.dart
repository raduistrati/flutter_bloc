import 'package:rxdart/rxdart.dart';
import 'package:bloc_architecture_test/src/models/trailer_model.dart';
import 'package:bloc_architecture_test/src/resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Stream<Future<TrailerModel>> get moviesTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  Future<TrailerModel> _trailerModelSeed = Future(() => TrailerModel.fromJson({'id':0, 'results':[]}));
  _itemTransformer() {
    return ScanStreamTransformer(
        (Future<TrailerModel> trailer, int id, int index) {
      trailer = _repository.fetchTrailers(id);
      return trailer;
    }, _trailerModelSeed);
  }
}
