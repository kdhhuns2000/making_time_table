import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:time_table/constants.dart';
import 'home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: InitialPage(),
      ),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageWidgetState();
}

class _InitialPageWidgetState extends State<InitialPage> {
  bool selected = true;
  double _opacity = 0.0;
  final _animationDuration = 1000;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: _animationDuration), () {
      setState(() {
        selected = !selected;
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: _animationDuration),
                  opacity: _opacity,
                  child: Image(
                    image: AssetImage('assets/image/title.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  width: 400.0,
                  height: selected ? 100.0 : 300.0,
                  color: Colors.transparent,
                  alignment: selected ? Alignment.center : AlignmentDirectional.center,
                  duration: Duration(milliseconds: _animationDuration),
                  curve: Curves.fastOutSlowIn,
                  child: Image(
                    image: AssetImage('assets/image/logo.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: _animationDuration),
                opacity: _opacity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kDefaultAppColor,
                            disabledBackgroundColor: Colors.grey,
                            fixedSize: const Size(double.maxFinite, double.infinity),
                            textStyle: const TextStyle(fontSize: 30.0),
                          ),
                          onPressed: () {
                            setState(() {
                              selected = !selected;
                              _opacity = 0.0;
                            });
                            Future.delayed(Duration(milliseconds: _animationDuration), () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(child: const Home(), type: PageTransitionType.fade),
                                (route) => false,
                              );
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              '시간표 만들기',
                              style: TextStyle(fontFamily: 'GmarketSansTTFMedium', fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
