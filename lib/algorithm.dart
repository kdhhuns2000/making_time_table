import 'cart.dart';
import 'constants.dart';

List subjectTable = List.generate(5, (index) => []);
Map<String, List> lectureValue = {};
List overLabList = [];
List pageList = [];


// original
// void Calculate2() {
//   Combination();
//   int index = -1;
//   cartList.forEach((subject) {
//     index++;
//     var timePlace = subject['timeplace'];
//     if (timePlace is List) {
//       timePlace.forEach((time) {
//         time['name'] = subject['name'];
//         time['color'] = kTimeTableColorList[index % 8];
//         subjectTable[int.parse(time['day']);].add(time);
//       });
//     } else {
//       timePlace['name'] = subject['name'];
//       timePlace['color'] = kTimeTableColorList[index % 8];
//       subjectTable[int.parse(timePlace['day'])].add(timePlace);
//     }
//   });
// }

Map<String, List> OverLapCheck() {
  Map<String, List> lectureValue = <String, List>{};
  cartList.forEach((subject) {
    if (!lectureValue.containsKey(subject['name'])) {
      lectureValue[subject['name']] = [];
    }
    if (lectureValue[subject['name']] != null) {
      lectureValue[subject['name']]?.add(subject['id']);
    }
    print(subject['name'] + " " + lectureValue[subject['name']].toString());
  });
  List lectureList = [];
  lectureValue.forEach((key, value) {
    lectureList.add({});
    lectureList[lectureList.length - 1][key] = value;
  });
  print(lectureValue.keys.toList());
  return lectureValue;
}

// 전공 중복 순열 조합하기 전 초기화
List lectureName = [];

void Combination() {
  lectureValue = OverLapCheck();
  lectureName = lectureValue.keys.toList();
  tmp = [];
  overLabList = [];
  dfs(0);
  print(overLabList);
  print(overLabList[0].length);
}

// 전공 중복 순열하여 조합하는 알고리즘
List tmp = [];

void dfs(int cnt) {
  if (cnt == lectureValue.length) {
    List input = List.generate(tmp.length, (index) => tmp[index]);
    overLabList.add(input);
    return;
  } else {
    int? loop = lectureValue[lectureName[cnt]]?.length;
    for (int i = 0; i < loop!; i++) {
      tmp.add(lectureValue[lectureName[cnt]]![i]);
      dfs(cnt + 1);
      tmp.removeLast();
    }
  }
}

void Calculate() {
  pageList = [];
  Combination();
  print("오버랩 길이 " + overLabList.length.toString());
  for (int i = 0; i < overLabList.length; i++) {
    subjectTable = List.generate(5, (index) => []);
    int index = -1;

    print(overLabList.length);
    for (int j = 0; j < overLabList[i].length; j++) {
      cartList.forEach((subject) {
        if (subject['id'] == overLabList[i][j]) {
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
        }
      });
    }
    pageList.add(subjectTable);
  }
}

// 정렬 알고리즘