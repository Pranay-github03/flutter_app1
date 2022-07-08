import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator",
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  AssetImage assetImage = AssetImage('images/2.png');
  final _minimumPadding = 5.0;
  // Initial Selected Value
  String dropdownvalue = 'Rupee';

  // List of items in our dropdown menu
  var items = [
    'Rupee',
    'Dollar',
    'Pounds',
    'yuan',
    'Euro',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Simple Interest Calculator"),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: Column(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Principle',
                  hintText: 'Principle',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rate Of Interest',
                  hintText: 'Rate Of Interest',
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      hintText: 'Term',
                      labelText: 'Term',
                    ),
                    maxLength: 5,
                  ),
                ),
                Container(
                  width: _minimumPadding * 5,
                ),
                Expanded(
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Center(child: Text(items)),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                  child: ElevatedButton(
                      child: Text('Calculate'), onPressed: () {})),
              Container(
                width: _minimumPadding * 2,
              ),
              Expanded(
                  child:
                      ElevatedButton(child: Text('Reset'), onPressed: () {})),
            ])
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('Flutter256.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }
}
