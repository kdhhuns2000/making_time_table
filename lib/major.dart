import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'major_leaf.dart';
import 'constants.dart';

final majorMap = [
  {
    '가천리버럴아츠컬리지': [
      '한국학전공',
      '가천리버럴아츠칼리지',
      '첨단의료기기학과(계약학과)',
      '게임·영상학과(계약학과)',
      '디스플레이학과(계약학과)',
    ],
  },
  {
    '경영대학': [],
  },
  {
    '사회과학대학': [],
  },
  {
    '인문대학': [],
  },
  {
    '법과대학': [],
  },
  {
    '공과대학': [],
  },
  {
    '바이오나노대학': [],
  },
  {
    'IT융합대학': [
      '소프트웨어학과',
      '컴퓨터공학과',
      '전자공학과',
      '전자공학과(야)',
      '전기공학과',
      'AI·소프트웨어학부(소프트웨어전공)',
      'AI·소프트웨어학부(인공지능전공)',
      '의공학과',
      '스마트시티융합학과',
      '컴퓨터공학부(컴퓨터공학전공)',
      '컴퓨터공학부(스마트보안전공)',
      '전자공학부(전자공학전공)',
    ],
  },
  {
    '한의과대학': [],
  },
  {
    '예술·체육대학': [],
  },
  {
    '미래산업대학': [],
  },
  {
    'IT대학': [],
  },
  {
    '예술대학': [],
  },
  {
    'LINC+': [],
  },
  {
    '아시아문화연구소': [],
  },
  {
    '융합전공': [],
  },
  {
    '글로벌교양대학': [],
  },
  {
    '생활과학대학': [],
  },
  {
    '경상대학': [],
  },
  {
    '건축대학': [],
  },
  {
    '자연과학대학': [],
  },
  {
    '의과대학': [],
  },
  {
    '약학대학': [],
  },
  {
    '간호대학': [],
  },
  {
    '보건과학대학': [],
  },
  {
    '경상학부': [],
  },
  {
    '생명과학부': [],
  },
  {
    '보건과학부': [],
  },
  {
    '의료공학부': [],
  },
  {
    '정보공학부': [],
  },
  {
    '체육과학부': [],
  },
  {
    '의료경영학부': [],
  },
  {
    '부처협업형': [],
  },
  {
    '창업대학': [],
  },
];

class MajorList extends StatelessWidget {
  const MajorList({Key? key}) : super(key: key);

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
        title: const Text(
          '전공',
          style: TextStyle(
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
        ),
        child: ListView.separated(
          itemCount: majorMap.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () async {
                final majorLeafRes = await Navigator.push(
                  context,
                  PageTransition(
                      child: MajorLeafList(
                        title: majorMap[index].keys.single,
                        major: majorMap[index].values.elementAt(0),
                      ),
                      type: PageTransitionType.rightToLeft),
                );
                if (majorLeafRes != "previous")
                  Navigator.pop(context, majorLeafRes);
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
                        majorMap[index].keys.single,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: kFilterListFontSize,
                          color: Colors.black,
                        ),
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
