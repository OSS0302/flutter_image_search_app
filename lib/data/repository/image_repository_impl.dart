import 'package:image_search_app/data/data_source/image_api.dart';
import 'package:image_search_app/data/mapper/image_mapper.dart';
import 'package:image_search_app/data/model/image_item.dart';

import '../../core/result.dart';
import 'image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final _api =ImageApi();

  @override
  Future<Result<List<ImageItem>>> getImageItem(String query) async{
    try {
      final dto = await _api.getImageString(query);
      if(dto.hits == null){
        return Result.success([]);
      }
      return Result.success(dto.hits!.map((e) => e.toImageItem()).toList());
    }catch(e) {
      return Result.error(Exception(e.toString()));
    }

  }

}