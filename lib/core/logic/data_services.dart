import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchData() async {
    DocumentSnapshot snapshot = await _firestore.collection('clientData').doc('your_document').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      // Process your data here
    }
  }
  void listenToUpdates() {
    _firestore.collection('clientData').doc('your_document').snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        // Process your data here
      }
    });
  }

}
