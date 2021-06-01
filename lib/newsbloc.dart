import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:newsApp/Models/ArticleModel.dart';

enum NewsActions { Fetch }

class NewsBloc {
  final _newsStreamController = StreamController<List<ArticleModel>>();
  StreamSink<List<ArticleModel>> get newsSink => _newsStreamController.sink;
  Stream<List<ArticleModel>> get newsStream => _newsStreamController.stream;

  final _eventStreamController = StreamController<NewsActions>();
  StreamSink<NewsActions> get eventSink => _eventStreamController.sink;
  Stream<NewsActions> get eventStream => _eventStreamController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsActions.Fetch) {
        try {
          var result = await getNews();
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      }
    });
  }

  void dispose() {
    _eventStreamController.close();
    _newsStreamController.close();
  }

  Future<List<ArticleModel>> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=Technology&apiKey=b62abbf777b64c56997280c44a97c0bd";
    List<ArticleModel> news = [];
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              content: element["content"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"]);
          news.add(articleModel);
        }
      });
    }
    return news;
  }
}
