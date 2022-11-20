import 'cart.dart';
import 'constants.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'search.dart';
import 'table.dart';

ValueNotifier<int> selectedIndex = ValueNotifier<int>(1);
//ValueNotifier<int> cartLength = ValueNotifier<int>(0);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  static const List<Widget> _widgetList = <Widget>[
    TableWidget(),
    Search(),
    Cart(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _widgetList.length, vsync: this);
    _tabController.index = 1;
    selectedIndex.addListener(() {
      setState(() {
        _tabController.index = selectedIndex.value;
      });
    });
    // cartLength.addListener(() {
    //   setState(() {});
    // });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex.value = index;
    });
  }

  // bool _visibility() {
  //   return cartLength.value != 0 ? true : false;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: _widgetList[selectedIndex.value], // 위젯 여러개 넣을 자리
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: kDefaultAppColor,
            items: const [
              TabItem(icon: Icons.schedule, title: '시간표'),
              TabItem(icon: Icons.home, title: '홈'),
              TabItem(icon: Icons.shopping_cart, title: '장바구니')
            ],
            controller: _tabController,
            onTap: _onItemTapped,
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   selectedLabelStyle: TextStyle(fontFamily: kDefaultFont, fontSize: 15.0),
          //   unselectedLabelStyle: TextStyle(fontFamily: kDefaultFont, fontSize: 15.0),
          //   items: <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.schedule),
          //       label: '시간표',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: '홈',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Stack(
          //         children: <Widget>[
          //           Icon(Icons.notifications),
          //           Visibility(
          //             visible: _visibility(),
          //             child: Positioned(
          //               right: 0,
          //               child: Container(
          //                 padding: EdgeInsets.all(1),
          //                 decoration: BoxDecoration(
          //                   color: Colors.red,
          //                   borderRadius: BorderRadius.circular(6),
          //                 ),
          //                 constraints: BoxConstraints(
          //                   minWidth: 12,
          //                   minHeight: 12,
          //                 ),
          //                 child: Text(
          //                   cartList.length.toString(),
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 8,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //       label: '장바구니',
          //     ),
          //   ],
          //   currentIndex: selectedIndex.value,
          //   selectedItemColor: kDefaultAppColor,
          //   onTap: _onItemTapped,
          // ),
        ),
      ),
    );
  }
}
