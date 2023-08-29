import 'package:flutter/material.dart';

class NoDataView extends StatefulWidget {


  final VoidCallback emptyRetry; //无数据事件处理

  const NoDataView(this.emptyRetry, {super.key});

  @override
  _NoDataViewState createState() => _NoDataViewState();
}

class _NoDataViewState extends State<NoDataView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: 750,
        height: double.infinity,
        child: InkWell(
          onTap: widget.emptyRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 405,
                height: 281,
                child: Image.asset('images/no_data.png'),
              ),
              const Text('暂无相关数据,轻触重试~',style: TextStyle(color: Colors.black,fontSize: 24),)
            ],
          ),
        )
    );
  }
}