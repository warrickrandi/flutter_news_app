import 'package:news/presenters/base/ibase_presenter.dart';
import 'package:news/services/api.dart';
import 'package:news/views/base/base_view.dart';

class BasePresenter<V extends BaseView> implements IBasePresenter<V> ,APIListner {
  V _view;
  ApiClient apiClient;

  BasePresenter(V view) {
    _view = view;
    apiClient = ApiClient(this);
  }

  @override
  void setView(V view) {
    this._view = view;
  }

  @override
  V getView() {
    return _view;
  }

  @override
  void onAPICallSuccess(int callerID, response) {
    getView().onBaseSuccess(callerID,response);
  }

  
  
}