import 'package:flutter/material.dart';

import 'load_state.dart';

/// 多状态页面
class MultiStatePage extends StatefulWidget {
  const MultiStatePage({super.key});

  @override
  State<StatefulWidget> createState() => _MultiStatePageState();
}

class _MultiStatePageState extends State<MultiStatePage> {
  LoadState _layoutState = LoadState.State_Loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiStatePage'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: LoadStateLayout(
              state: _layoutState,
              emptyRetry: () {
                setState(() {
                  _layoutState = LoadState.State_Empty;
                });
              },
              errorRetry: () {
                setState(() {
                  _layoutState = LoadState.State_Error;
                });
              },
              successWidget: const Center(
                child: Text("successWidget"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _layoutState = LoadState.State_Success;
                    });
                  },
                  child: const Text("成功")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _layoutState = LoadState.State_Error;
                    });
                  },
                  child: const Text("错误")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _layoutState = LoadState.State_Empty;
                    });
                  },
                  child: const Text("空数据")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _layoutState = LoadState.State_Loading;
                    });
                  },
                  child: const Text("加载中")),
            ],
          )
        ],
      ),
    );
  }
}
