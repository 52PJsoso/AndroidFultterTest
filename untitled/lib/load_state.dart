import 'package:flutter/material.dart';
import 'package:untitled/no_data.dart';
//四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

///根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {

  final LoadState state; //页面状态
  final Widget successWidget;//成功视图
  final VoidCallback errorRetry; //错误事件处理
  final VoidCallback emptyRetry; //空数据事件处理

  const LoadStateLayout(
      {Key? key,
        this.state = LoadState.State_Loading,//默认为加载状态
        required this.successWidget,
        required this.errorRetry,
        required this.emptyRetry
      })
      : super(key: key);

  @override
  State<LoadStateLayout> createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget? get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.successWidget;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return _loadingView;
        break;
      case LoadState.State_Empty:
        return NoDataView(widget.emptyRetry);
        break;
      default:
        return null;
    }
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: Icon(Icons.downloading), //Image.asset('images/cargo_loading.gif')
            ),
            const Text('拼命加载中...',style: TextStyle(color: Colors.black,fontSize: 24),)],
        ),
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: InkWell(
          onTap: widget.errorRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 405,
                height: 317,
                child: Image.asset('images/load_error.png'),
              ),
              Text("加载失败，请轻触重试!",style: TextStyle(color: Colors.black,fontSize: 24),),
            ],
          ),
        )
    );
  }
}