// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/category_news.dart';
import 'package:news/data/local_data.dart';
import 'package:news/data/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/view/article_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> category = [];
  List<ArticleModel> article = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    category = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    article = newsClass.news;
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
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) : Container(
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

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, this.categoryTitle, this.imageUrl});

  final String? categoryTitle, imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category: categoryTitle)));
      },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26,
                ),
                child: Text(categoryTitle!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
    );
  }
}
class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, this.imageUrl, this.articleTitle, this.description,this.url});
final String? imageUrl , articleTitle , description, url;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url,)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl!,
              ),
            ),
            Text(articleTitle!, style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),),
            Text(articleTitle!, style: TextStyle(
              color: Colors.grey,
            ),),
          ],
        ),
      ),
    );
  }
}

