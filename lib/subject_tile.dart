import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cart.dart';

List<bool?> _isChecked = List.filled(100, false);

class SubjectTile extends StatefulWidget {
  final String majorFieldRange; // 전공/영역 매칭
  final String? searchText; // 검색어 매칭
  const SubjectTile({Key? key, this.searchText, required this.majorFieldRange}) : super(key: key);
  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  Future<dynamic> _fetch() async {
    String jsonString = await rootBundle.loadString('assets/json/${widget.majorFieldRange}.json');
    var map = jsonDecode(jsonString);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    String? searchText = widget.searchText;
    return FutureBuilder(
      future: _fetch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
        if (snapshot.hasData == false) {
          return Center(
            child: Text(
              '전공/영역을 선택해주세요',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }

        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
              style: TextStyle(fontSize: 15),
            ),
          );
        }

        // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
        else {
          // searchText의 내용이 있는 데이터를 제거
          snapshot.data[0]['subject'].removeWhere((data) => !data['name'].toString().contains(searchText!));
          return ListView.separated(
            itemCount: snapshot.data[0]['subject'].length,
            itemBuilder: (BuildContext context, int index) {
              var subjectData = snapshot.data[0]['subject'][index];
              return CheckboxListTile(
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
                value: _isChecked[index],
                onChanged: (bool? value) {
                  if (value == true) {
                    cartList.add(subjectData);
                  } else if (value == false) {
                    cartList.removeWhere((element) => element['id'] == subjectData['id']);
                  }
                  print(cartList);
                  setState(() {
                    _isChecked[index] = value;
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
          );
        }
      },
    );
  }
}
