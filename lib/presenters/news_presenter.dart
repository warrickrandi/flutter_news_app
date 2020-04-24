import 'package:news/presenters/base/base_presenter.dart';
import 'package:news/presenters/inews_presenter.dart';
import 'package:news/services/api.dart';
import 'package:news/views/news_view.dart';

class NewsPresenter extends BasePresenter<NewsView> implements INewsPresenter {

  NewsPresenter(NewsView view) : super(view);
  String request = '';

  @override
  void getTopNews() {
    request = 'country=us&sortBy=publishedAt&';
    apiClient.callApi(ApiClient.id_get_top_news, request);
  }

  @override
  void getNews(String keyword) {
    request = 'q='+keyword+'&sortBy=publishedAt&';
    apiClient.callApi(ApiClient.id_get_all_news, request);
  }

  
  @override
  void onAPICallSuccess(int callerID, response) {
    super.onAPICallSuccess(callerID, response);
    getView().onSuccess(callerID, response);
  }

  

}