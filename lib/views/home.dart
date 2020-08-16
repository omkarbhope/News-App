import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/category_models.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
      ) :SingleChildScrollView(
              child: Container(
                
          child: Column(
            children: <Widget>[
            /// Categories
            Container(
              padding: EdgeInsets.symmetric(horizontal:16),
              height: 70,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                })
            ),

            /// Blogs
            Container(
              
              padding: EdgeInsets.symmetric(horizontal:16),
              child: ListView.builder(
                itemCount: articles.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context,index){
                  return BlogTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,
                    url: articles[index].url,
                  );
                })
            )

            ]
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: categoryName.toLowerCase(),
          )
          ));
      },
          child: Container(
        margin: EdgeInsets.only(right:16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,width:120,height:60, fit: BoxFit.cover)
              ),
            Container(
              alignment: Alignment.center,
              width:120,height:60,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),)
            )
          ],
          )
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            url: url,
          )
          ));
      },
          child: Container(
        padding: EdgeInsets.only(bottom:10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl)
              ),
            Text(title, style : TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.w600
            )),
            SizedBox(height: 8),
            Text(desc, style: TextStyle(
              color: Colors.grey
            )),
          ],
        )
        
      ),
    );
  }
}
