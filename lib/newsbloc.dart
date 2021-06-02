import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:newsApp/Models/ArticleModel.dart';

enum NewsActions {
  Technology,
  Entertainment,
  General,
  Health,
  Science,
  Sports,
  Business
}

class NewsBloc {
  final _newsStreamController = StreamController<List<ArticleModel>>();
  StreamSink<List<ArticleModel>> get newsSink => _newsStreamController.sink;
  Stream<List<ArticleModel>> get newsStream => _newsStreamController.stream;

  final _eventStreamController = StreamController<NewsActions>();
  StreamSink<NewsActions> get eventSink => _eventStreamController.sink;
  Stream<NewsActions> get eventStream => _eventStreamController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsActions.Technology) {
        try {
          var result = await getNews(cat: 'Technology');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.Business) {
        try {
          var result = await getNews(cat: 'Business');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.Entertainment) {
        try {
          var result = await getNews(cat: 'Entertainment');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.General) {
        try {
          var result = await getNews(cat: 'General');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.Health) {
        try {
          var result = await getNews(cat: 'Health');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.Science) {
        try {
          var result = await getNews(cat: 'Science');
          newsSink.add(result);
        } on Exception catch (e) {
          newsSink.addError("something went wrong");
        }
      } else if (event == NewsActions.Sports) {
        try {
          var result = await getNews(cat: 'Sports');
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

  Future<List<ArticleModel>> getNews({String cat}) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=b62abbf777b64c56997280c44a97c0bd";
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
