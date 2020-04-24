import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_model.dart';
import 'package:news/presenters/news_presenter.dart';
import 'package:news/screens/base/base_stateful.dart';
import 'package:news/screens/single_view.dart';
import 'package:news/services/api.dart';
import 'package:news/views/news_view.dart';

class Category extends StatefulWidget {

  final String catName;
  Category({
    this.catName,
  });

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends BaseStatefulState<Category, NewsPresenter>
    implements NewsView {
  
  bool loading = true;
  NewsModel _newsModel = new NewsModel();

  @override
  void initState() {
    loading = true;
    setPresenter(createPresenter());
    super.initState();
    getTopNews();
  }

  getTopNews() {
    getPresenter().getNews(widget.catName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          (widget.catName+' NEWS').toUpperCase(),
          style: TextStyle(fontSize: 30,),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
        padding: EdgeInsets.only(top:10,left: 8),
                itemCount: _newsModel.articles.length,
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
                            child: _newsModel.articles[index].urlToImage == null ? Image(image: AssetImage('assets/images/default.jpg')) : Image.network(
                                _newsModel.articles[index].urlToImage,
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 101,
                            height: 80,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 65,
                                  width:
                                      MediaQuery.of(context).size.width - 101,
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
                                ),
                                Container(
                                  height: 15,
                                  width:
                                      MediaQuery.of(context).size.width - 101,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      DateFormat.yMd().add_jm().format(
                                          DateTime.parse(_newsModel
                                                  .articles[index].publishedAt)
                                              .toLocal()),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SingleView(url: _newsModel.articles[index].url,)));
                    },
                    
                  );
                },
              )
    );
  }

  @override
  NewsPresenter createPresenter() {
    return NewsPresenter(this);
  }

  @override
  void onSuccess(int callerId, response) {
    
    if (callerId == ApiClient.id_get_all_news) {
      if (response['status'] == 'ok') {
        setState(() {
          _newsModel = new NewsModel();
          _newsModel = NewsModel.fromJson(response);
          loading = false;
        });
      }
    }
  }
}