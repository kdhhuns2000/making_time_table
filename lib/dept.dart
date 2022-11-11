import 'constants.dart';
import 'elective.dart';
import 'major.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

final deptList = ['전공', '교양'];

class DeptList extends StatelessWidget {
  const DeptList({
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
        ),
        child: ListView.separated(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () async {
                final filterRes = await Navigator.push(
                  context,
                  PageTransition(
                    child: (index == 0) ? MajorList() : ElectiveList(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
                Navigator.pop(context, filterRes);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 50.0,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        deptList[index],
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
