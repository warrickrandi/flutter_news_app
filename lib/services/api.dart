import 'package:http/http.dart';
import 'package:news/models/news_model.dart';

class APIListner {
  void onAPICallSuccess(int callerID, dynamic response) {}
}

class ApiClient {
  static final baseURL = "http://newsapi.org/v2/";
  static final apiKey = 'f74db46861524a7da4500a787c7005b8';
  static const id_get_top_news = 10;
  static const id_get_all_news = 11;

  APIListner _listener;

  ApiClient(this._listener);

  callApi(int callerID, String request) {
    
    get(baseURL + getEndPoint(callerID)+'?'+ request +'apiKey=' + apiKey).then((res) {
      this._listener.onAPICallSuccess(callerID, jsonCodec.decode(res.body));
    });
  }

  String getEndPoint(int callerID) {
    switch (callerID) {
      case (ApiClient.id_get_top_news):
        return 'top-headlines';

      case (ApiClient.id_get_all_news):
        return 'everything';

        break;
      default:
    }
    return null;
  }
}
