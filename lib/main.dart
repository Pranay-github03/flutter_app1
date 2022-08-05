import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.cyan[100],
        accentColor: Colors.cyan[400],
      )));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  //localEyesImage
  AssetImage assetImage = AssetImage('images/2.png');
  //genralPadding
  final _minimumPadding = 5.0;
  // Initial Selected Value
  String dropdownvalue = 'Rupee';
  //finaldisplayResult
  var _displayResult = "";
  // List of items in our dropdown menu
  var currency = [
    'Rupee',
    'Dollar',
    'Pounds',
    'yuan',
    'Euro',
  ];
  TextEditingController principleController = TextEditingController();
  TextEditingController roiContoller = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Simple Interest Calculator"),
        ),
      ),
      body: Form(
        //formKey Gives current Status of our form
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextFormField(
                    controller: principleController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      //null is not equal to isEmpty (Spaces are empty but not null)
                      if (value!.isEmpty) {
                        return 'Please fill the principle amount';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Principle',
                      hintText: 'Principle',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: TextFormField(
                    controller: roiContoller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Rate of interest';
                      }
                    },
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
                      child: TextFormField(
                        controller: termController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter time';
                          }
                        },
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

                        // Array list of currency
                        items: currency.map((String items) {
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
                    child: Text('Calculate'),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          this._displayResult = _calculateResult();
                        }
                      });
                    },
                  )),
                  Container(
                    width: _minimumPadding * 2,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          })),
                ]),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(this._displayResult),
                )
              ],
            )),
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

  String _calculateResult() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiContoller.text);
    double term = double.parse(termController.text);

    double displayResult = principle + (principle * roi * term) / 100;
    String result =
        "After $term years,Your investment will be worth $displayResult $dropdownvalue ";
    return result;
  }

  void _reset() {
    principleController.text = '';
    roiContoller.text = "";
    termController.text = "";
    this._displayResult = "";
    this.dropdownvalue = currency[0];
  }
}
