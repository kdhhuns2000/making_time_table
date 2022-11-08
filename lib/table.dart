import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

List week = ['월', '화', '수', '목', '금'];
var kColumnLength = 22;

class TableWidget extends StatefulWidget {
  TableWidget({
    Key? key,
    this.cartList,
  }) : super(key: key);
  List<dynamic>? cartList;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {

  late int _selectedPage;
  late final PageController _pageController;

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
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Container(
                  height: kColumnLength / 2 * kBoxSize + kColumnLength,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      buildTimeColumn(),
                      for (int i = 0; i < 5; i++) ...buildDayColumn(i),
                    ],
                  ),
                ),
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
          padding: const EdgeInsets.all(32.0),
          child: PageViewDotIndicator(
            currentItem: _selectedPage,
            count: 3,
            unselectedColor: Colors.black26,
            selectedColor: Colors.blue,
            size: const Size(12, 12),
            unselectedSize: const Size(8, 8),
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.topCenter,
            fadeEdges: false,
          ),
        ),
      ],
    );
  }

  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
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

  List<Widget> buildDayColumn(int index) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                color: Colors.blue,
                child: Text(
                  '강의',
                ),
              ),
              // kTableFirstColumnHeight가 default, 시작시간만큼 kBoxSize * n
              top: kTableFirstColumnHeight + (kBoxSize * 2),
              // 1 kBoxSize / 1시간
              height: kBoxSize + kBoxSize,
              width: 100,
            ),
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
            )
          ],
        ),
      ),
    ];
  }
}
