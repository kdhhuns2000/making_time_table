import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'major.dart';
import 'constants.dart';

final major_field_list = ['전공', '교양'];

class MajorFieldList extends StatelessWidget {
  const MajorFieldList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        title: const Text(
          '전공/영역',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () async {
                if (index == 0) {
                  final major_res = await Navigator.push(
                    context,
                    PageTransition(
                      child: MajorList(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                  Navigator.pop(context, major_res);
                } else {
                  // 교양으로 보내기
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50.0,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        major_field_list[index],
                        style: const TextStyle(fontSize: kFilterListFontSize, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50.0,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
        ),
      ),
    );
  }
}
