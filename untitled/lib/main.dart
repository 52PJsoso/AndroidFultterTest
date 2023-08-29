import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/RefreshPage.dart';
import 'package:untitled/dio/ApiClient.dart';
import 'package:untitled/load_state.dart';

import 'dio/RequestCallBack.dart';
import 'multi_state_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //获取方法通道
  static const platform = MethodChannel('com.flutter.guide.MethodChannel');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final dio = Dio();

  // final bean2 = Person.fromJson({"callback": "callback", "data": "data"});

  void getHttp() async {
    final response = await dio.get('https://dart.dev');
    print("response:$response");
  }

  void _incrementCounter() {
    ApiClient().getUserInfo({"a": 12}).then((value) {
      value.lastName;
      print("value:$value");
    }).catchError((e) {
      print("onError:$e");
    });
    ApiClient().login(RequestCallBack(), map: {"age": 12});
  }

  @override
  void initState() {
    // TODO: implement initState
    getHttp();
    super.initState();
    //接受原生发送过来的数据
    MyApp.platform.setMethodCallHandler((call) async {
      if (call.method == "sendDataX") {
        var name = call.arguments['name'];
        var age = call.arguments['age'];
        print("Flutter接受到 name:$name,age:$age");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  //关闭Activity
                  SystemNavigator.pop();
                },
                child: const Text("关闭Activity")),
            ElevatedButton(
              onPressed: () async {
                //调用原生方法
                var result = await MyApp.platform.invokeMethod(
                    'sendData', {'name': 'laomeng', 'age': 18});
                var name = result['name'];
                var age = result['age'];
                print("Flutter接受到 name:$name,age:$age");
              },
              child: const Text("发送数据到原生"),
            ),
            ElevatedButton(
                onPressed: () {
                  //打开原生页面
                  MyApp.platform.invokeMethod(
                      'goSecondActivity', {'data': '我是Flutter传递过来的数据'});
                },
                child: const Text("打开原生页面")),
            ElevatedButton(
                onPressed: () {
                  //打开多状态View页面
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MultiStatePage(),
                      ));
                },
                child: const Text("打开多状态View页面")),
            ElevatedButton(
                onPressed: () {
                  //打开多状态View页面
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RefreshPage(),
                      ));
                },
                child: const Text("打开下拉刷新上拉加载页面")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
