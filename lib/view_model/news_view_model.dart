import 'package:inews/models/categories_new_model.dart';
import 'package:inews/models/news_channel_headlines_model.dart';
import 'package:inews/models/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> FetchNewsChannelapi() async {
    final response = await _rep.FetchNewsChannelapi();
    return response;
  }

  Future<CategoriesNewsModel> FetchCategoriesNewsapi(String category) async {
    final response = await _rep.FetchCategoriesNewsapi(category);
    return response;
  }
}
