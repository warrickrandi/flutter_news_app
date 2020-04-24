import 'package:flutter/material.dart';
import 'package:news/presenters/base/base_presenter.dart';
import 'package:news/screens/base/ibase_stateful.dart';
import 'package:news/views/base/base_view.dart';

abstract class BaseStatefulState<S extends StatefulWidget, P extends BasePresenter> extends State<S> implements IBaseStatefulState<P> , BaseView {
  P _presenter;

  BaseStatefulState(){

  }

  P getPresenter() => _presenter;

  @override
  void setPresenter(P presenter) => _presenter = presenter;

  @override
  void onBaseSuccess(int callerId, response) {
    // TODO: implement onBaseSuccess
  }
}