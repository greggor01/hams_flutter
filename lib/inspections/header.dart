import 'package:flutter/material.dart';
import '../enums.dart';

class HeaderState extends State<Header> {
  int selectedYear = DateTime.now().year;
  final currentYear = DateTime.now().year;
  final defaultYearButtonElevation = 4.0;

  void _onYearSelected(year) {
    setState(() {
      selectedYear = year;
    });
    widget.onSelectedYearChanged(year);
  }

  Widget buildYearButton(year) {
    return Container(
        height: 50,
        child: RaisedButton(
            elevation: selectedYear == year ? 2.0 : defaultYearButtonElevation,
            shape: BeveledRectangleBorder(),
            color: selectedYear == year ? Colors.blue[100] : Colors.blue[50],
            textColor: Colors.black,
            highlightColor: Colors.blue[200],
            child: Text(year.toString()),
            onPressed: () {
              _onYearSelected(year);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //can use a SafeArea instead of the margin setting below to accomplish the same result
        child: Container(
            //margin: MediaQuery.of(context).padding, //need this when no AppBar and want content below the device statusbar
            color: Colors.black,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  buildYearButton(currentYear),
                  buildYearButton(currentYear - 1),
                ]),
                // Expanded(flex: 1, child: Container(color: Colors.black)),
                Spacer(),
                Container(
                    height: 50.0,
                    color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: PopupMenuButton(
                      child: Icon(Icons.more_horiz),
                      onSelected: (MenuOptions result) {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuOptions>>[
                            const PopupMenuItem<MenuOptions>(
                                child: Text('Logout'),
                                value: MenuOptions.logout)
                          ],
                    ))
              ],
            )));
  }
}

class Header extends StatefulWidget {
  final Function onSelectedYearChanged;
  @override
  HeaderState createState() => new HeaderState();

  Header({this.onSelectedYearChanged});
}
