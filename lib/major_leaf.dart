import 'package:flutter/material.dart';
import 'constants.dart';

class MajorLeafList extends StatelessWidget {
  final String title;
  final List major;

  const MajorLeafList({
    super.key,
    required this.title,
    required this.major,
  });
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
        title: Text(
          title,
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
          //border: Border.all(width: 0.7),
        ),
        child: ListView.separated(
          itemCount: major.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () {
                Navigator.pop(context, major[index]);
              },
              child: Center(
                child: Text(
                  major[index],
                  style: const TextStyle(fontSize: kFilterListFontSize, color: Colors.black),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
        ),
      ),
    );
  }
}
