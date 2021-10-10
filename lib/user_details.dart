import 'package:flutter/material.dart';
import 'package:registration_flutter_servlet/user_model.dart';

class DetailOfUser extends StatefulWidget {
  late User userLists;

  DetailOfUser(this.userLists);

  @override
  _DetailOfUserState createState() => _DetailOfUserState(this.userLists);
}

class _DetailOfUserState extends State<DetailOfUser> {
  late User userLists;

  _DetailOfUserState(this.userLists);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Container(


        child: Container(
          padding: EdgeInsets.all(8),

          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Name: ${userLists.name.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Mobile: ${userLists.mobile.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Email: ${userLists.email.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Age: ${userLists.age.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Gender: ${userLists.gender.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Address: ${userLists.address.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Role: ${userLists.roledesc.toString()}",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),

        ),

      )
    );
  }
}
