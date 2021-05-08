import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';

class Generator {
  var rand;
  var intStream;
  init(StreamController<int> stream) {
    rand = new math.Random();
    intStream = stream;
  }

  //ランダムは整数を作る
  generate() {
    var data = rand.nextInt(100);
    print("generatorが$dataをつくったよ");
    intStream.sink.add(data);
  }
}

class Coordinator {
  var intStream;
  var strStream;
  init(StreamController<int> intStream,
      StreamController<String> srtStream) {
    this.intStream = intStream;
    this.strStream = strStream;
  }

  // 流れてきたものをintからstringにする
  coorinate() {
    intStream.stream.listen((data) async {
      String newData = data.toString();
      print("coordinatorが$dataから$newDataにへんかんしたよ");
      strStream.sink.add(newData);
    });
  }
}

class Consumer {
  var strStream;
  init(StreamController<String> stream) {
    strStream = stream;
  }

  // 流れてきたらStringを表示する
  consume() {
    strStream.stream.listen((data) async {
      print("consumerが$dataを使ったよ");
    });
  }
}