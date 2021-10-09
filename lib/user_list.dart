import 'package:flutter/material.dart';
import 'package:registration_flutter_servlet/user_details.dart';
import 'package:registration_flutter_servlet/user_model.dart';

class UserList extends StatefulWidget {
  late List<User> userLists;

  UserList(this.userLists);

  @override
  _UserListState createState() => _UserListState(this.userLists);
}

class _UserListState extends State<UserList> {
  late List<User> userLists;

  _UserListState(this.userLists);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: new ListView.builder(
        itemCount: userLists == null ? 0 : userLists.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailOfUser(
                        userLists[index]
                    ),),);},
              child: new Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  padding: EdgeInsets.all(8),

                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Name: ${userLists[index].name.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Mobile: ${userLists[index].mobile.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Email: ${userLists[index].email.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Age: ${userLists[index].age.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Gender: ${userLists[index].gender.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Address: ${userLists[index].address.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Role: ${userLists[index].roledesc.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),

                ),

              ),
          );

        },

      ),
    );
  }
}
