import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'table.dart';
import 'constants.dart';

List<dynamic> cartList = [];

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    if (cartList.isEmpty) {
      return const Center(
        child: Text(
          '장바구니가 비어있습니다.',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartList.length,
              itemBuilder: (BuildContext context, int index) {
                var subjectData = cartList[index];
                return ListTile(
                  title: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${subjectData['name'].toString()}\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${subjectData['professor'].toString()}\n',
                        )
                      ],
                    ),
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${subjectData['time'].toString()}\n${subjectData['place']}\n${subjectData['type']} ${subjectData['credit']}학점 ${subjectData['id']}',
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kClipRRectBorderRadius),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  disabledBackgroundColor: Colors.grey,
                  fixedSize: const Size(double.maxFinite, double.infinity),
                  textStyle: const TextStyle(fontSize: kClipRRectFontSize),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: TableWidget(
                        cartList: cartList,
                      ),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('시간표 조합'),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
