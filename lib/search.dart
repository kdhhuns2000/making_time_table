import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'subject_tile.dart';
import 'major_field.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String major_field_range = '선택';
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black12,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: _onPressed,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: '전공/영역: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextSpan(
                          text: major_field_range,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimSearchBar(
            width: MediaQuery.of(context).size.width,
            textController: _textController,
            onSuffixTap: () {
              setState(() {
                _textController.clear();
              });
            },
            rtl: true,
          ),
          Expanded(child: SubjectTile(searchText: _textController.text,)),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.deepPurple,
          //       disabledBackgroundColor: Colors.grey,
          //       fixedSize: const Size(double.maxFinite, double.infinity),
          //       textStyle: const TextStyle(fontSize: 30.0),
          //     ),
          //     onPressed: () {},
          //     child: const Padding(
          //       padding: EdgeInsets.all(10.0),
          //       child: Text('시간표 검색'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future _onPressed() async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => FilterList()));
    final res = await Navigator.push(
      context,
      PageTransition(
        child: const MajorFieldList(),
        type: PageTransitionType.bottomToTop,
      ),
    );
    if (res != null) {
      setState(() {
        major_field_range = res;
      });
    }
  }
}
