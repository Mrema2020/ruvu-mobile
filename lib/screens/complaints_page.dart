import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsPage extends StatefulWidget {
  final String? userId;

  ComplaintsPage({required this.userId});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    final CollectionReference _dataCollection =
        _firestore.collection('reports');
    String? userID = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('My complaints'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('reports')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index){
                Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    title: Text("Category: ${data['category']}"),
                    subtitle:Text("Description: ${data['description']}"),
                    trailing:  Text("Address: ${data['address']}"),
                    leading: Icon(Icons.feedback,
                      color: Colors.orangeAccent,
                    ),
                  ),
                );
              } );
        }
      ),
    );
  }
}
