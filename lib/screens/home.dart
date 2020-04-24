import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_model.dart';
import 'package:news/presenters/news_presenter.dart';
import 'package:news/screens/base/base_stateful.dart';
import 'package:news/screens/category.dart';
import 'package:news/screens/single_view.dart';
import 'package:news/screens/top_news.dart';
import 'package:news/services/api.dart';
import 'package:news/views/news_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulState<HomePage, NewsPresenter>
    implements NewsView {
  bool loading = true;
  bool aloading = true;
  NewsModel _newsModel = new NewsModel();
  NewsModel _anewsModel = new NewsModel();

  @override
  void initState() {
    loading = true;
    aloading = true;
    setPresenter(createPresenter());
    super.initState();
    getTopNews();
  }

  getTopNews() {
    getPresenter().getTopNews();
    getPresenter().getNews('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          'NEWS',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Top News',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                InkWell(
                  child: Text(
                    'View all',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TopNews()));
                  },
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: _newsModel.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: _newsModel.articles[index]
                                                        .urlToImage ==
                                                    null
                                                ? Image(
                                                    image: AssetImage(
                                                        'assets/images/default.jpg'))
                                                : NetworkImage(_newsModel
                                                    .articles[index]
                                                    .urlToImage),
                                            fit: BoxFit.cover)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            _newsModel.articles[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleView(
                                          url: _newsModel.articles[index].url,
                                        )));
                          },
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.red,
                      label: Text(
                        'Business',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'business',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.yellow,
                      label: Text(
                        'Entertainment',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'entertainment',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.pink,
                      label: Text(
                        'General',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'general',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.limeAccent,
                      label: Text(
                        'Health',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'health',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.tealAccent,
                      label: Text(
                        'Science',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'science',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.indigo,
                      label: Text(
                        'Sports',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'sports',
                                )));
                  },
                ),
                GestureDetector(
                  child: Chip(
                      elevation: 5,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.purpleAccent,
                      label: Text(
                        'Technology',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  catName: 'technology',
                                )));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 470,
              child: aloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: _anewsModel.articles.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            height: 80,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child:
                                      _anewsModel.articles[index].urlToImage ==
                                              null
                                          ? Image(
                                              image: AssetImage(
                                                  'assets/images/default.jpg'))
                                          : Image.network(
                                              _anewsModel
                                                  .articles[index].urlToImage,
                                              fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 101,
                                  height: 80,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 65,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                101,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                _anewsModel
                                                    .articles[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                101,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            DateFormat.yMd().add_jm().format(
                                                DateTime.parse(_anewsModel
                                                        .articles[index]
                                                        .publishedAt)
                                                    .toLocal()),
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleView(
                                          url: _anewsModel.articles[index].url,
                                        )));
                          },
                        );
                      },
                    ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered by newsapi.org & Developed by Randika Hasheen',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  NewsPresenter createPresenter() {
    return NewsPresenter(this);
  }

  @override
  void onSuccess(int callerId, response) {
    if (callerId == ApiClient.id_get_top_news) {
      if (response['status'] == 'ok') {
        setState(() {
          _newsModel = new NewsModel();
          _newsModel = NewsModel.fromJson(response);
          loading = false;
        });
      }
    }
    if (callerId == ApiClient.id_get_all_news) {
      if (response['status'] == 'ok') {
        setState(() {
          _anewsModel = new NewsModel();
          _anewsModel = NewsModel.fromJson(response);
          aloading = false;
        });
      }
    }
  }
}
