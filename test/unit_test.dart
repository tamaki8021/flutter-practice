import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_practice_app/calc.dart';

void main() {
  test("mytest1", () {
    var ans = 10;
    expect(ans, 10);
  });

  test("mytest2", () {
    var param1 = 10;
    var param2 = 20;
    var calc = Calc();
    var ans = calc.add(param1, param2);

    expect(ans, 30);
  });
}

