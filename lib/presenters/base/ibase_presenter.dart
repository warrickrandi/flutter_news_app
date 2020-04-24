import 'package:news/views/base/base_view.dart';

class IBasePresenter<V extends BaseView> {
  void setView(V view) {}
  V getView() {}
}