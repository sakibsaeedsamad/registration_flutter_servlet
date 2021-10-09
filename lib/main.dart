import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:registration_flutter_servlet/role_model.dart';
import 'package:registration_flutter_servlet/user_list.dart';
import 'package:registration_flutter_servlet/user_model.dart';

import 'gender_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  late List<Role> roleLists;
  late List<Gender> genderLists;
  late List<User> userLists;
  String uri = "http://192.168.0.111:8084/RegistrationServeletApi/UserApi";

  DateTime? _selectedDate;
  String? _userName;
  String? _mobileNo;
  String? _emailAddress;
  String? _addressVal;
  String? _myRoleSelection = null;


  List<Map> _myJson = [
    {"id": 0, "name": "<New>"},
    {"id": 1, "name": "Test Practice"}
  ];



 int _radioSelected = 1;
  // Default Radio Button Item
  String radioItem = 'Gender';
  String? _radioVal = null;



  Future<bool> _getRole(String requestCode) async {
   // String uri = "http://10.11.201.61:8084/RegistrationServeletApi/UserApi";
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> body = {"requestCode": requestCode};
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(Uri.parse(uri),
        headers: headers, body: body, encoding: encoding);

    setState(() {
      List<dynamic> body = json.decode(response.body);
      //print(response.body);

      roleLists = body
          .map(
            (dynamic item) => Role.fromJson(item),
          )
          .toList();
      print(roleLists?[0].desc);
    });

    return true;
  }

  Future<bool> _getGender(String requestCode) async {
   Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> body = {"requestCode": requestCode};
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(Uri.parse(uri),
        headers: headers, body: body, encoding: encoding);

    setState(() {
      List<dynamic> body = json.decode(response.body);
      //print(response.body);

      genderLists = body
          .map(
            (dynamic item) => Gender.fromJson(item),
          )
          .toList();
      print(genderLists?[0].genDesc);
    });

    return true;
  }

  Future<bool> _getUSers(String requestCode) async {
   // String uri = "http://10.11.201.61:8084/RegistrationServeletApi/UserApi";
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> body = {"requestCode": requestCode};
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(Uri.parse(uri),
        headers: headers, body: body, encoding: encoding);

    setState(() {
      List<dynamic> body = json.decode(response.body);
      //print(response.body);

      userLists = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();
      print(userLists?[0].name);
    });

    return true;
  }

  @override
  void initState() {
    super.initState();
    this._getRole("2");
    this._getGender("3");
    this._getUSers("4");
  }

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' User Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formStateKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter User Name';
                        }
                        if (value.trim() == "")
                          return "Only Space is Not Valid!!!";
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                      // controller: _employeeNameController,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          // hintText: "User Name",
                          labelText: "User Name",
                          icon: Icon(
                            Icons.business_center,
                            color: Colors.purple,
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Mobile no';
                        }
                        if (value.trim() == "")
                          return "Only Space is Not Valid!!!";
                        return null;
                      },
                      onSaved: (value) {
                        _mobileNo = value;
                      },
                      // controller: _employeeNameController,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          // hintText: "Mobile No",
                          labelText: "Mobile No",
                          icon: Icon(
                            Icons.business_center,
                            color: Colors.purple,
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        }
                        if (value.trim() == "")
                          return "Only Space is Not Valid!!!";
                        return null;
                      },
                      onSaved: (value) {
                        _emailAddress = value;
                      },
                      // controller: _employeeNameController,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          // hintText: "Email",
                          labelText: "Email",
                          icon: Icon(
                            Icons.business_center,
                            color: Colors.purple,
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.business_center,
                                        color: Colors.purple),
                                    Text(_selectedDate != null
                                        ? "Birth Date: $_selectedDate"
                                        : "Birth Date: "),
                                  ])
                            ]),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RaisedButton(
                                  child: Text('DoB'),
                                  onPressed: _pickDateDialog),
                              SizedBox(height: 20),
                            ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.business_center,
                                        color: Colors.purple),
                                    Text("Gender:"),
                                  ])
                            ]),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(mainAxisSize: MainAxisSize.min,
                                children:  new List.generate(genderLists.length, (index) =>
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(genderLists[index].genDesc),
                                              Radio(
                                                value: genderLists[index].genCode,
                                                groupValue: _radioSelected,
                                                activeColor: Colors.blue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _radioSelected = value.hashCode;
                                                    _radioVal = genderLists[index].genCode;
                                                  });
                                                },
                                              ),

                                            ],
                                        ),
                                      ),
                                    )




                                )

                            ),
                          ],
                        )
                        ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Address';
                        }
                        if (value.trim() == "")
                          return "Only Space is Not Valid!!!";
                        return null;
                      },
                      onSaved: (value) {
                        _addressVal = value;
                      },
                      // controller: _employeeNameController,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          // hintText: "Address",
                          labelText: "Address",
                          icon: Icon(
                            Icons.business_center,
                            color: Colors.purple,
                          ),
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.business_center,
                                        color: Colors.purple),
                                    Text("Role: "),
                                  ])
                            ]),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            DropdownButton<String>(
                              isDense: true,
                              hint: new Text("Select"),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.red, fontSize: 18),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              value:
                              _myRoleSelection,//.isNotEmpty ? _myRoleSelection : null,
                              onChanged: (value) {
                                setState(() {
                                  _myRoleSelection = value!;
                                });
                              },
                              items: roleLists.map((Role role) {
                                return DropdownMenuItem<String>(
                                  value: role.code,
                                  child: new Text(role.desc),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.purple,
                                child: Text("Register"),
                                onPressed: () {},
                              ),
                            ]),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.purple,
                              child: Text("Show user"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserList(
                                     userLists
                                    ),),);},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
