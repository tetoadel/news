import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:news/models/article_model.dart';

class News{
  List<ArticleModel>news =[];

  Future<void>getNews()async{
    String url ='https://newsapi.org/v2/top-headlines?country=us&apiKey=783883086d8941c3afdd2b8f25ff4c54';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);


    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        if(element['description'] != null && element['urlToImage'] != null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']
          );
          news.add(articleModel);
        }
      });

    }
  }
}

class CategoriesNewsClass{
  List<ArticleModel>news =[];

  Future<void>getNews(String category )async{

    String url ='https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=34909c51897443df86e314eabd0d00a7';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'=='ok']){
      jsonData['articles'].forEach((element){
        if(element['description']!=null && element['urlToImage']!=null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']
          );
          news.add(articleModel);
        }
      });

    }
  }
}