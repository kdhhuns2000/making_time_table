import 'algorithm.dart';
import 'constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

List week = ['월', '화', '수', '목', '금'];
var kColumnLength = 22;

class TableWidget extends StatefulWidget {
  const TableWidget({
    Key? key,
    this.cartList,
  }) : super(key: key);
  final List<dynamic>? cartList;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late int _selectedPage;
  late final PageController _pageController;
  final List<String> items = [
    '공강',
    '강의평',
    '늦은 등교',
    '빠른 하교',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedPage = 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: pageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      color: kDefaultAppColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '시간표 ${index + 1}/${pageList.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: kDefaultFontBold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xFFCC668B),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                '정렬',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 40,
                              buttonPadding: const EdgeInsets.only(right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              value: selectedValue,
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontFamily: kDefaultFont,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                selectedValue = value as String;
                                setState(() {
                                  if (value == '공강') {
                                    GapSort();
                                  } else if (value == '강의평') {
                                    LectureRateSort();
                                  } else if (value == '늦은 등교') {
                                    LateBeforeSort();
                                  } else if (value == '빠른 하교') {
                                    EarlyAfterSort();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: kColumnLength / 2 * kBoxSize + kColumnLength,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        buildTimeColumn(),
                        for (int i = 0; i < 5; i++) ...buildDayColumn(index, i),
                      ],
                    ),
                  ),
                ],
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                child: PageViewDotIndicator(
                  currentItem: _selectedPage,
                  count: pageList.length != 0 ? pageList.length : 1,
                  unselectedColor: Colors.black26,
                  selectedColor: kDefaultAppColor,
                  size: const Size(12, 12),
                  unselectedSize: const Size(8, 8),
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.topCenter,
                  fadeEdges: false,
                ),
              ),
              Expanded(
                child: Text(
                  '평균 강의평점 ${pageList[_selectedPage][5].isNaN ? '없음' : pageList[_selectedPage][5].toStringAsFixed(2)}',
                  style: TextStyle(fontFamily: kDefaultFont),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: kTableFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int page, int index) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  child: Text(
                    '${week[index]}',
                  ),
                ),
                ...List.generate(
                  kColumnLength,
                  (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
            // test

            // Positioned(
            //   child: Container(
            //     color: Colors.blue,
            //     child: Text(
            //       '강의',
            //     ),
            //   ),
            //   // kTableFirstColumnHeight가 default, 시작시간만큼 kBoxSize * n
            //   //top: kTableFirstColumnHeight + (kBoxSize * 2),
            //   top: 306.0,
            //   // 1 kBoxSize / 1시간
            //   //height: kBoxSize + kBoxSize, -> 2시간
            //   height: 65.0,
            //   width: 100,
            // ),

            // 강의 들어갈 부분

            for (int i = 0; i < pageList[page][index].length; i++)
              Positioned(
                top: kTableFirstColumnHeight + (kBoxSize * (int.parse(pageList[page][index][i]['start']) - 108) / 12),
                // 1 kBoxSize / 1시간
                //height: kBoxSize + kBoxSize, -> 2시간
                height: kBoxSize *
                    (int.parse(pageList[page][index][i]['end']) - int.parse(pageList[page][index][i]['start'])) /
                    12,
                width: 100,
                child: Container(
                  color: pageList[page][index][i]['color'],
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: pageList[page][index][i]['name'] + '\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: pageList[page][index][i]['place'],
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ];
  }
}
