import 'package:chat_app/blocs/groups/group_cubit.dart';
import 'package:chat_app/comps/app_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/messages_screen.dart';

class GroupList extends StatelessWidget {
  const GroupList({
    super.key,
    this.groupStream,
  });

  final groupStream;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    var cubit = GroupCubit.get(context);
    return StreamBuilder(
        stream: groupStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot values = snapshot.data as QuerySnapshot;
            return Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: values.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.customNavigator(
                            context: context,
                            screen: MessagesScreen(
                              groupName: values.docs[index]["groupName"],
                              userMail: cubit.user!.email!,
                            ),
                            finish: false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: screenheight * 0.1,
                          decoration: BoxDecoration(color: Color(0xffff4040),borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xffff4040))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Text(
                                      "$index",
                                      style: TextStyle(color: Color(0xffff4040),fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(values.docs[index]["groupName"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: Text("There are no groups"),
            );
          }
        });
  }
}
