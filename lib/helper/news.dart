import 'dart:convert';

import 'package:news_app/models/article_models.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleModel> news = [];

  Future<void> getNews() async {

    String url = "http://newsapi.org/v2/top-headlines?country=in&apiKey=e787269940c047e7b23f7b2d8be8533b";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!= null && element['description']!= null)
        {
          ArticleModel articleModel = new ArticleModel(
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],
            title: element['title'],
          );

          news.add(articleModel);

        }
      });
    }
  }

}

class CategoryNewsClass{

  List<ArticleModel> news = [];

  Future<void> getNewsForCategory(String category) async {
    
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=e787269940c047e7b23f7b2d8be8533b";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element['urlToImage']!= null && element['description']!= null)
        {
          ArticleModel articleModel = new ArticleModel(
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            content: element['content'],
            title: element['title'],
          );

          news.add(articleModel);

        }
      });
    }
  }

}

