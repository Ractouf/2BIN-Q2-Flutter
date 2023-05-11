import 'package:ex4/model/article.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  final _articles = [...defaultArticles];
  bool _displayRead = false;

  List get articles => _articles.where((element) => element.read == _displayRead).toList();
  bool get displayRead => _displayRead;

  Article getById(int id) {
    return _articles.firstWhere((article) => article.id == id);
  }

  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void deleteArticle(int id) {
      _articles.removeWhere((article) => article.id == id);
      notifyListeners();
  }

  void switchRead(int id) {
      Article article = getById(id);
      article.read = !article.read;
      notifyListeners();
  }

  void switchDisplayRead() {
    _displayRead = !displayRead;
    notifyListeners();
  }
}
