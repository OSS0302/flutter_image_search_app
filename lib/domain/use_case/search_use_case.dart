import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/domain/repository/pixabay_respository.dart';

class SearchUseCase {
  final PixabayRepository _repository;

  const SearchUseCase({
    required PixabayRepository repository,
  }) : _repository = repository;

  Future<Result<List<PixabayItem>>> execute(String query) async{
    final result = await _repository.getPixabayItem(query);
    switch(result) {

      case Success<List<PixabayItem>>():
        Result.success(result.data.toList());
      case Error<List<PixabayItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}