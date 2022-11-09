import 'cart.dart';

List subjectTable = List.generate(5, (index) => []);

void Calculate() {
  cartList.forEach((subject) {
    var timePlace = subject['timeplace'];
    if (timePlace is List) {
      timePlace.forEach((time) {
        time['name'] = subject['name'];
        subjectTable[int.parse(time['day'])].add(time);
      });
    } else {
      timePlace['name'] = subject['name'];
      subjectTable[int.parse(timePlace['day'])].add(timePlace);
    }
  });
}
