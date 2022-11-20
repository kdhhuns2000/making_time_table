import 'package:flutter/material.dart';
import 'constants.dart';

final electiveMap = [
  '교양전체',
  '교직이론영역',
  '교과교육영역',
  '교육실습영역',
  '교직소양영역',
  '[융합]인간과예술',
  '[융합]사회와역사',
  '[융합]자연과과학',
  '[융합]세계와언어',
  '[계교]인문사회과학',
  '[계교]자연과학',
  '[계교]예·체능',
  '[기초]인성과리더십',
  '[기초]의사소통',
  '[기초]창의와사고',
  '일반교양',
  '[기초]소프트웨어기초',
  '군사학',
];

class ElectiveList extends StatelessWidget {
  final String title = '교양';

  const ElectiveList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop("previous"),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: kDefaultFontBold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          //border: Border.all(width: 0.7),
        ),
        child: ListView.separated(
          itemCount: electiveMap.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () {
                Navigator.pop(context, electiveMap[index]);
              },
              child: Center(
                child: Text(
                  electiveMap[index],
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: kFilterListFontSize,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
        ),
      ),
    );
  }
}
