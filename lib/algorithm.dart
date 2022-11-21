import 'cart.dart';
import 'constants.dart';

List subjectTable = [];
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
  });
  List lectureList = [];
  lectureValue.forEach((key, value) {
    lectureList.add({});
    lectureList[lectureList.length - 1][key] = value;
  });
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
  for (int i = 0; i < overLabList.length; i++) {
    subjectTable = List.generate(6, (index) => []);
    int index = -1;

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
    if (Valid(subjectTable)) {
      pageList.add(subjectTable);
      subjectTable[5] = addLectureRate(overLabList[i]);
    }
  }
}

// 유효성 검사
bool Valid(List list) {
  bool valid = true;
  for (int i = 0; i < 5; i++) {
    List<bool> time = List.generate(300, (index) => false);
    subjectTable[i].forEach((day) {
      for (int j = int.parse(day['start']); j < int.parse(day['end']); j++) {
        if (time[j + 1] == true) {
          valid = false;
          break;
        } else {
          time[j + 1] = true;
        }
      }
    });
  }
  return valid;
}

// 강의평점 추가
double addLectureRate(List list) {
  double averageLectureRate = 0.0;
  int nonZeroLectureRateCount = 0;
  list.forEach((id) {
    cartList.forEach((subject) {
      if (subject['id'] == id) {
        if (subject['lectureRate'] != '0') {
          nonZeroLectureRateCount++;
          averageLectureRate += double.parse(subject['lectureRate']);
        }
      }
    });
  });
  averageLectureRate /= nonZeroLectureRateCount;
  return averageLectureRate;
}

// 공강 정렬 알고리즘
void GapSort() {
  pageList.sort((a, b) {
    int aGapValue = 0, bGapValue = 0;
    for (int i = 0; i < 5; i++) {
      if (a[i].length == 0) {
        aGapValue++;
      }
      if (b[i].length == 0) {
        bGapValue++;
      }
    }
    return bGapValue.compareTo(aGapValue);
  });
}

// 강의평 정렬 알고리즘
void LectureRateSort() {
  pageList.sort((a, b) => b[5].compareTo(a[5]));
}

// 늦은 등교 정렬 알고리즘
void LateBeforeSort() {
  pageList.sort((a, b) {
    int aLatest = 300, bLatest = 300;
    for (int i = 0; i < 5; i++) {
      a[i].sort((c, d) => int.parse(c['start']).compareTo(int.parse(d['start'])));
      b[i].sort((c, d) => int.parse(c['start']).compareTo(int.parse(d['start'])));
      if (a[i].length != 0) {
        if (aLatest > int.parse(a[i][0]['start'])) {
          aLatest = int.parse(a[i][0]['start']);
        }
      }
      if (b[i].length != 0) {
        if (bLatest > int.parse(b[i][0]['start'])) {
          bLatest = int.parse(b[i][0]['start']);
        }
      }
    }
    return bLatest.compareTo(aLatest);
  });
}

// 빠른 하교 정렬 알고리즘
void EarlyAfterSort() {
  pageList.sort((a, b) {
    int aEarliest = 0, bEarliest = 0;
    for (int i = 0; i < 5; i++) {
      a[i].sort((c, d) => int.parse(d['end']).compareTo(int.parse(c['end'])));
      b[i].sort((c, d) => int.parse(d['end']).compareTo(int.parse(c['end'])));
      print(a[i]);
      print(b[i]);
      if (a[i].length != 0) {
        if (aEarliest < int.parse(a[i][0]['end'])) {
          aEarliest = int.parse(a[i][0]['end']);
        }
      }
      if (b[i].length != 0) {
        if (bEarliest < int.parse(b[i][0]['end'])) {
          bEarliest = int.parse(b[i][0]['end']);
        }
      }
    }
    return aEarliest.compareTo(bEarliest);
  });
}