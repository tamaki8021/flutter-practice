import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice_app/test_page1.dart';
import 'package:flutter_practice_app/stream_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  String _type = "偶数";
  bool flag = false;

  var intStream = StreamController<int>();
  var stringStream = StreamController<String>.broadcast();
  var generator = new Generator();
  var coodinator = new Coordinator();
  var consumer = new Consumer();

  void _incrementCounter() {
    generator.generate();
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _type = "偶数";
      } else {
        _type = "奇数";
      }
    });
  }

  _click() async {
    setState(() {
      flag = !flag;
    });
  }

  @override
  void initState() {
    generator.init(intStream);
    coodinator.init(intStream, stringStream);
    consumer.init(stringStream);
    coodinator.coorinate();
    consumer.consume();

    super.initState();
  }

  @override
  void dispose() {
    intStream.close();
    stringStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.create),
            Text("new title")
          ],),
        ),
        drawer: Drawer(child: Center(child: Text("Drawer"))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'カウンター',
              ),
              Text('text'),
              TextButton(onPressed: () => {
                print('Clicked Button')
              }, child: Text('update')),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              if (_counter % 2 == 0)
                Text(
                  '$_type',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              TextButton(onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return TestPage1();
                }))
              }, child: Text("次のページへ"),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                  Icon(
                    Icons.audiotrack,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  Icon(
                    Icons.beach_access,
                    color: Colors.blue,
                    size: 36.0,
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: flag ? 0.1 : 1.0,
                duration: Duration(seconds: 3),
                child: Text(
                  "消える文字",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              AnimatedSize(
                vsync: this,
                duration: Duration(seconds: 3),
                child: SizedBox(
                  width: flag ? 50 : 200,
                  height: flag ? 50 : 200,
                  child: Container(color: Colors.purple,),
                ),
              ),
              AnimatedAlign(
                alignment: flag ? Alignment.topLeft : Alignment.bottomRight,
                duration: Duration(seconds: 3),
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(color: Colors.green,)
                ),
              ),
              AnimatedContainer(
                  duration: Duration(seconds: 3),
                  width: flag ? 100 : 50,
                  height: flag ? 50 : 100,
                  padding: flag ? EdgeInsets.all(0) : EdgeInsets.all(30),
                  margin: flag ? EdgeInsets.all(0) : EdgeInsets.all(30),
                  transform: flag ? Matrix4.skewX(0.0) : Matrix4.skewX(0.3),
                  color: flag ? Colors.blue : Colors.grey
              ),
              AnimatedSwitcher(
                  duration: Duration(seconds: 3),
                  child: flag ? Text("none") : Icon(Icons.favorite, color: Colors.pink)
              ),
              StreamBuilder<String>(
                  stream: stringStream.stream,
                  initialData: "",
                  builder: (context, snapshot) {
                    return Text(
                      'RANDOM : ${snapshot.data}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
              ),
            ],
          ),
        ),
        floatingActionButton:
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
          FloatingActionButton(onPressed: _click, child: Icon(Icons.check),)
        ],)
    );
  }
}
