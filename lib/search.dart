import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'constants.dart';
import 'dept.dart';
import 'subject_tile.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

String deptRange = '선택';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(kClipRRectBorderRadius),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black12,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: kClipRRectFontSize),
                  ),
                  onPressed: _onPressed,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: '전공/영역: ',
                        ),
                        TextSpan(
                          text: deptRange,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
            autoFocus: true,
          ),
          Expanded(
            child: SubjectTile(
              dept: deptRange,
              searchText: _textController.text,
            ),
          ),
        ],
      ),
    );
  }

  Future _onPressed() async {
    final res = await Navigator.push(
      context,
      PageTransition(
        child: const DeptList(),
        type: PageTransitionType.bottomToTop,
      ),
    );
    if (res != null) {
      setState(() {
        deptRange = res;
      });
    }
  }
}
