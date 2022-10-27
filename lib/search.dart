import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'filter_list.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => FilterList()));
                    Navigator.push(context, PageTransition(child: FilterList(), type: PageTransitionType.bottomToTop));
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '전공/영역: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextSpan(
                          text: '전체',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(30),
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       foregroundColor: Colors.black,
              //       backgroundColor: Colors.black12,
              //       padding: const EdgeInsets.all(16.0),
              //       textStyle: const TextStyle(fontSize: 20),
              //     ),
              //     onPressed: () {},
              //     child: Text('asdf'),
              //   ),
              // ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                disabledBackgroundColor: Colors.grey,
                fixedSize: const Size(double.maxFinite, double.infinity),
                textStyle: const TextStyle(fontSize: 30.0),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('시간표 검색'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
