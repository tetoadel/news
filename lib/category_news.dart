// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:news/data/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/view/home_screen.dart';

class CategoryNews extends StatefulWidget {
  CategoryNews({super.key ,required this.category});
  String? category;

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> article = [];
  List<CategoryModel> category = [];

  bool loading = true;
  @override
  void initState() {
    getCategoryNews();
    super.initState();
  }
  getCategoryNews(){
    CategoriesNewsClass categoriesNewsClass = CategoriesNewsClass();
    categoriesNewsClass.getNews(widget.category!);
    article = categoriesNewsClass.news;
    setState(() {
      loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset('assets/download.png',width: 300,),
      ),
      body: loading ?
      Center(
        child: CircularProgressIndicator(),
      ) :
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child:  Column(
            children: [
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: category.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => CategoryTile(
                    categoryTitle: category[index].categoryName,
                    imageUrl: category[index].imageUrl,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child:ListView.builder(
                  itemCount: article.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ArticleTile(
                    imageUrl: article[index].urlToImage,
                    articleTitle: article[index].title,
                    description: article[index].description,
                    url: article[index].url,

                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
