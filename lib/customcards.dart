import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapi_pratice/model/newsapi.dart';

import 'newsdetail.dart';

class VerticalListCard extends StatelessWidget {
  Articles articles;
  VerticalListCard(this.articles, {Key? key}) : super(key: key);

  String dateformatter(String date){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = dateFormat.parse(date);
    DateFormat temp = DateFormat("MMM dd, yyyy");
    String d = temp.format(format);
    return d;
  }

  String urlformatter(String url)
  {
    String temp = url.split("://")[1];
    String temp1  = temp.split(".")[0];
    return temp1;

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
        (context)=>NewsDetails(articles:articles,)));
      },
      child: Card(
        elevation: 1,
        child: Container(

          child: Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: articles.urlToImage!,
                        fit: BoxFit.cover,
                        width: 130,
                        height: 100,
                        errorWidget: (context, url, error)=> const Icon(Icons.do_not_disturb_alt, color: Colors.red,),
                        placeholder: (context, url)=>const CircularProgressIndicator(),
                      ),
                      const Positioned(
                        left: 50,
                        top: 40,
                        child: Icon(Icons.play_circle,
                          color: Colors.white, size: 30,),)
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: size.width/1.7,
                child: Column(
                  children: [
                     Text(articles.title!,
                      style: TextStyle(
                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        //button
                        Container(
                          padding: EdgeInsets.all(8.0),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),

                          ),
                          child: Text(urlformatter(articles.url!) ,
                            style: TextStyle(
                                color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold
                            ),),

                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: 70,
                            child: Text(dateformatter(articles.publishedAt!),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

