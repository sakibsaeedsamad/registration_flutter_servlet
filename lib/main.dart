import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:registration_flutter_servlet/role_model.dart';
import 'package:registration_flutter_servlet/user_creation_response_model.dart';
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

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
   List<Role>? roleLists;
   List<Gender>? genderLists;
   List<User>? userLists;
  late UserCreationResponse ucResponse;

  String uri = "http://10.11.201.61:8084/RegistrationServeletApi/UserApi";

  //String uri = "http://192.168.0.111:8084/RegistrationServeletApi/UserApi";

  DateTime? _selectedDate;
  String formattedDob = "";

  String _userName = '';
  String _mobileNo = '';
  String _emailAddress = '';
  String _addressVal = '';
  String _myRoleSelection = '';

  String _groupValue = '';

  final _userNameController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _addressValController = TextEditingController();

  late AnimationController controller;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  Future<bool> _getRole(String requestCode) async {
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

  Future<bool> _createUser(String requestCode,
      String name,
      String mobile,
      String email,
      String dob,
      String gender,
      String address,
      String role) async {
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, dynamic> body = {
      "requestCode": requestCode,
      "name": name,
      "mobile": mobile,
      "email": email,
      "dob": dob,
      "gender": gender,
      "address": address,
      "role": role
    };
    final encoding = Encoding.getByName('utf-8');

    var response = await http.post(Uri.parse(uri),
        headers: headers, body: body, encoding: encoding);

    setState(() {
      dynamic body = json.decode(response.body);
      print(response.body);

      ucResponse = UserCreationResponse.fromJson(body);

      if (ucResponse.name.isNotEmpty &&
          ucResponse.mobile.isNotEmpty &&
          ucResponse.email.isNotEmpty &&
          ucResponse.dob.isNotEmpty &&
          ucResponse.address.isNotEmpty &&
          ucResponse.gender.isNotEmpty &&
          ucResponse.role.isNotEmpty) {
        Fluttertoast.showToast(
          msg: "User inserted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        _userNameController.text = "";
        _mobileNoController.text = "";
        _emailAddressController.text = "";
        _addressValController.text = "";
      }
    });

    return true;
  }

  bool isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);

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
        formattedDob = DateFormat('dd/MM/yyyy').format(_selectedDate!);
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
        child: Container(

            child: (genderLists== null || userLists== null ||
                roleLists==null) ? _circularProgressbar() : new Column(
              children: <Widget>[
                Form(
                  key: _formStateKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter User Name';
                            }
                            if (value
                                .trim()
                                .length <= 4) {
                              return 'Please Enter User Name';
                            }
                            if (value.trim() == "")
                              return "Only Space is Not Valid!!!";
                            return null;
                          },
                          onSaved: (value) {
                            //_userName = value;
                          },
                          controller: _userNameController,
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
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Mobile no';
                            }
                            if (value
                                .trim()
                                .length < 11 ||
                                value
                                    .trim()
                                    .length > 11) {
                              return "Please Enter Valid Mobile No";
                            }
                            if (value.trim() == "")
                              return "Only Space is Not Valid!!!";
                            return null;
                          },
                          onSaved: (value) {
                            //_mobileNo = value;
                          },
                          controller: _mobileNoController,
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
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email';
                            }
                            if (isValidEmail(value.trim()) == false) {
                              return "Please Enter valid Email";
                            }
                            if (value.trim() == "")
                              return "Only Space is Not Valid!!!";
                            return null;
                          },
                          onSaved: (value) {
                            //_emailAddress = value;
                          },
                          controller: _emailAddressController,
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
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
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(_selectedDate != null
                                              ? "Birth Date: $formattedDob"
                                              : "Birth Date: ",
                                            style: TextStyle(
                                                color: Colors.purple
                                            ),),

                                        ),
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
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
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
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: Text("Gender:",
                                                    style: TextStyle(
                                                      color: Colors.purple,
                                                    ))),
                                          ])
                                    ]),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: new List.generate(
                                            genderLists!.length,
                                                (index) =>
                                                Container(
                                                  child: Flexible(
                                                    child: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: <Widget>[
                                                        Radio(
                                                          value: genderLists![index]
                                                              .genDesc,
                                                          //genderLists[index].genCode,
                                                          groupValue: _groupValue,
                                                          onChanged:
                                                          _valueChangedHandler(),
                                                        ),
                                                        Text(genderLists![index]
                                                            .genDesc),

                                                      ],
                                                    ),
                                                  ),
                                                ))),
                                  ],
                                )
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
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
                            //_addressVal = value;
                          },
                          controller: _addressValController,
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
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
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
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text("Role:",
                                                style: TextStyle(
                                                  color: Colors.purple,
                                                ))),
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  value: _myRoleSelection.isNotEmpty
                                      ? _myRoleSelection
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      _myRoleSelection = value!;
                                    });
                                  },
                                  items: roleLists!.map((Role role) {
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
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.purple,
                                    child: Text("Register"),
                                    onPressed: () {
                                      _userName = _userNameController.text;
                                      _mobileNo = _mobileNoController.text;
                                      _emailAddress =
                                          _emailAddressController.text;
                                      _addressVal = _addressValController.text;

                                      if (formattedDob.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please Select Your Dob",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                      if (_groupValue.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please Select Gender",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                      if (_myRoleSelection.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please Select Your Role",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                      if (_addressVal.isNotEmpty &&
                                          _emailAddress.isNotEmpty &&
                                          _userName.isNotEmpty &&
                                          _mobileNo.isNotEmpty &&
                                          formattedDob.isNotEmpty &&
                                          _groupValue.isNotEmpty &&
                                          _myRoleSelection.isNotEmpty) {
                                        print("Name: $_userName");
                                        print("Mobile: $_mobileNo");
                                        print("Email: $_emailAddress");
                                        print("Dob: $formattedDob");
                                        print("Address: $_addressVal");
                                        print("GenderCode: $_groupValue");
                                        print("RoleCode:$_myRoleSelection");

                                        _createUser(
                                            "1",
                                            _userName,
                                            _mobileNo,
                                            _emailAddress,
                                            formattedDob,
                                            _groupValue,
                                            _addressVal,
                                            _myRoleSelection);
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Please Enter All Value.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                    },
                                  ),
                                ]),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.purple,
                                  child: Text("Show user"),
                                  onPressed: () {
                                    _getUSers("4");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserList(userLists!),
                                      ),
                                    );
                                  },
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
            )
        ),
      ),
    );
  }

  Widget _circularProgressbar() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 300),
        child: CircularProgressIndicator(
          value: controller.value,
          backgroundColor: Colors.grey,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
        )
    );
  }
}
