import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
    
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNewsForCategory(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Omkar'),
            Text('News', style: TextStyle(
              color: Colors.blue,
            ))
          ]
        ),
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator()
      ),
      ):SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top:16),
          child: Column(
            children: <Widget> [
              Container(
                padding: EdgeInsets.symmetric(horizontal:16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage ?? "",
                      title: articles[index].title ?? "",
                      desc: articles[index].description ?? "",
                      url: articles[index].url ?? "",
                    );
                  })
              )
            ]
          )
        ),
      )
    );
  }
}

