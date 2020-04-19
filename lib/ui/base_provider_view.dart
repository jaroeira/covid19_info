import 'package:covid19_info/core/viewmodels/base_view_model.dart';
import 'package:covid19_info/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseProviderView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) modelCallBack;

  BaseProviderView({this.builder, this.modelCallBack});

  @override
  _BaseProviderViewState<T> createState() => _BaseProviderViewState<T>();
}

class _BaseProviderViewState<T extends BaseModel>
    extends State<BaseProviderView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    super.initState();
    if (widget.modelCallBack != null) {
      widget.modelCallBack(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
