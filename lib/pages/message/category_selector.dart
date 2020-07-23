import 'package:appdemo/common/style.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Messages', 'Online', 'Groups', 'Requests'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Style.size90,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Style.size20, vertical: Style.size30),
            child: Text(
              categories[index],
              style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.white60,
                  fontSize: Style.size20,
                  fontWeight: FontWeight.bold),
            ),
          ));
        },
      ),
    );
  }
}
