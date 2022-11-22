import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapi_pratice/api/get.dart';

import 'customcards.dart';
import 'model/newsapi.dart';

enum Gender{
  male, female, other
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override

  late Future<newsapi?> futurenews;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurenews = GetApi.getnewsdata(context) as Future<newsapi?>;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5112c7),//const Color(0xFF004794), //0xFFa418ed
        centerTitle: true,
        title: const Text(
          "Nepal Times",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 1,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.manage_search_rounded,
              color: Colors.grey,
              size: 30,
            ),
          )
        ],
      ),
      body: Container(
        width: size.width,
        child: Column(
          children: [
            FutureBuilder(
                future: futurenews,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container(
                          child: const Text(
                        "Try Loading Again",
                      ));
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Container(
                        child: const CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      if (!snapshot.hasData) {
                        //noData
                        return Container(
                          child: const Text("No news data available"),
                        );
                      } else {
                        //has data
                        return Column(
                          children: [
                            //Horizontal listview
                            Container(
                              height: size.height / 5,
                              child: ListView.builder(
                                primary: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data.articles.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:
                                    (BuildContext context, int index) => Card(
                                  elevation: 1,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:snapshot.data.articles[index].urlToImage,
                                                  fit: BoxFit.cover,
                                                  width: 130,
                                                  height: size.height/5.3,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.do_not_disturb_alt,
                                                    color: Colors.red,
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        height: 30, width: 30,
                                                          child: const CircularProgressIndicator()),
                                                ),
                                                Positioned(
                                                  bottom:10,
                                                    left:10,

                                                    child: Column(
                                                      children: [
                                                        Text(snapshot.data.articles[index].title,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16
                                                          ),),

                                                        Text(snapshot.data.articles[index].publishedAt,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16
                                                          ),),

                                                      ],
                                                    )
                                                ),
                                                const Positioned(
                                                  left: 50,
                                                  top: 40,
                                                  child: Icon(
                                                    Icons.play_circle,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Vertical listview
                            Container(
                              height: size.height / 1.5,
                              width: size.width,
                              child: ListView.builder(
                                primary: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data.articles.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        VerticalListCard(snapshot.data.articles[index]),
                              ),
                            ),
                          ],
                        );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
