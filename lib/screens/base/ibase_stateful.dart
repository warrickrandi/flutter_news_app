import 'package:news/presenters/base/base_presenter.dart';

class IBaseStatefulState<P extends BasePresenter> {
  P createPresenter(){}
  P getPresenter(){}

  void setPresenter(P presenter){}
}