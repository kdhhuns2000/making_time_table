import 'cart.dart';
import 'constants.dart';

List subjectTable = List.generate(5, (index) => []);

void Calculate() {
  int index = -1;
  cartList.forEach((subject) {
    index++;
    var timePlace = subject['timeplace'];
    if (timePlace is List) {
      timePlace.forEach((time) {
        time['name'] = subject['name'];
        time['color'] = kTimeTableColorList[index % 8];
        subjectTable[int.parse(time['day'])].add(time);
      });
    } else {
      timePlace['name'] = subject['name'];
      timePlace['color'] = kTimeTableColorList[index % 8];
      subjectTable[int.parse(timePlace['day'])].add(timePlace);
    }
  });
}
