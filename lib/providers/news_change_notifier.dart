import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_services.dart';

class NewsChangeNotifier extends ChangeNotifier {
  final NewServices _newServices;

  NewsChangeNotifier(this._newServices);

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();
    _articles = await _newServices.getArticles();
    _isLoading = false;
    notifyListeners();
  }
}
