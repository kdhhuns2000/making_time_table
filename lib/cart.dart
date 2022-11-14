import 'package:flutter/material.dart';
import 'constants.dart';
import 'home.dart';
import 'algorithm.dart';

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
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
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
                        subtitle: Text(
                            '${subjectData['time'].toString()}\n${subjectData['place']}\n${subjectData['type']} ${subjectData['credit']}학점 ${subjectData['id']}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.black12,
                            textStyle: const TextStyle(fontSize: kClipRRectFontSize),
                          ),
                          onPressed: () {
                            setState(() {
                              cartList.removeWhere((element) => element['id'] == subjectData['id']);
                            });
                            cartLength.value = cartList.length;
                            const snackBar = SnackBar(
                              content: Text('장바구니에서 과목을 지웠습니다.',),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: const Text('취소'),
                        ),
                      ),
                    ),
                  ],
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
                  Calculate();
                  setState(() {
                    selectedIndex.value = 0;
                  });
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
