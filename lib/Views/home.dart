import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/model/category_model.dart';
import 'package:news/model/article_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading= true;

  @override
  void initState() { 
    super.initState();
    categories = getCategories();
    getNews();
  }
 getNews() async { 
   News news = News();
   await news.getNews();
   articles = news.news;
   setState(() {
     _loading = false;
   });
 }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('GO',
          style: GoogleFonts.varelaRound(
            color:Colors.red,
            fontWeight: FontWeight.w700,
          ),
          ),
          Text('NEWS',
          style: GoogleFonts.oldStandardTt()
          )
        ],),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading  ? Center(
        child: Container( 
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView (
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
            //categories
            Container( 
              height: 70,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection:Axis.horizontal,
                itemBuilder: (context, index){
                  return CategoryTile( 
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                }
                ),
            ),

            //blogs
            Container(
              padding: EdgeInsets.only(top: 15), 
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index){
                  return BlogTile( 
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,

                  );
                },
                ),
            )
          ],),
        ) ,
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {

   final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
          child: Container(
        margin: EdgeInsets.only(right:15),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl, width: 120,height: 60, fit: BoxFit.cover,)),
          Container( 
            alignment: Alignment.center,
            width: 120,height: 60,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(6),
            color: Colors.black26,
            ),
            child: Text(categoryName,style: GoogleFonts.oldStandardTt(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
            ),
          )
        ],),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc;
  BlogTile({@required this.imageUrl, @required this.title, @required this.desc,});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(imageUrl)),
          SizedBox(height: 10,),
        Text(title,
        style: GoogleFonts.oldStandardTt(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87
        ),),
        SizedBox(height: 10,),
        Text(desc,
         style: GoogleFonts.oldStandardTt(
          color: Colors.black54
        ),
        )
      ],),
    );
  }
}