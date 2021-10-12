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
               child: Container(
                 width: double.infinity,
                 height: 250,
                 child: Card(
                   shadowColor: Colors.indigo,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),
                   ),
                   color: Colors.indigo.withOpacity(1),
                   child: Card(
                     shadowColor: Colors.indigo,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     color: Colors.white70.withOpacity(1),
                     
                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Expanded(
                             flex: 1,
                             child: Row(
                               children: [
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     
                                     children: [
                                       Text("Name"),
                                       Text(
                                         "${userLists[index].name.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     children: [
                                       Text("Mobile"),
                                       Text(
                                         "${userLists[index].mobile.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Expanded(
                             flex: 1,
                             child: Row(
                               children: [
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     children: [
                                       Text("Email"),
                                       Text(
                                         "${userLists[index].email.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     children: [
                                       Text("Age"),
                                       Text(
                                         "${userLists[index].age.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Expanded(
                             flex: 1,
                             child: Row(
                               children: [
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     children: [
                                       Text("Gender"),
                                       Text(
                                         "${userLists[index].gender.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                                 Expanded(
                                   flex: 1,
                                   child: Column(
                                     children: [
                                       Text("Address"),
                                       Text(
                                         "${userLists[index].address.toString()}",
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           Expanded(
                             flex: 1,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Expanded(
                                     flex: 1,
                                     child: Column(
                                       children: [
                                         Text("Role"),
                                         Text(
                                           "${userLists[index].roledesc.toString()}",
                                           style: TextStyle(fontWeight: FontWeight.bold),
                                         )
                                       ],
                                     )),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
          );

        },

      ),
    );
  }
}
