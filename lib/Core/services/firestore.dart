import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slidepuzzle/Core/Models/user.dart';

class FirestoreScore {
  final CollectionReference userscollection =
      FirebaseFirestore.instance.collection('users');
  String? userId;

  Future<bool> checkUser(String id) async {
    bool exist = false;
    try {
      await userscollection.doc(id).get().then((value) {
        exist = value.exists;
      });
      return exist;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot<Object?>> getUsers() async* {
    yield* userscollection.snapshots();
  }

  Future<void> addUser(User user) async {
    await userscollection.doc(user.id).set(
          user.toMap(),
        );
  }

  Future<void> updateUser(User user) async {
    await userscollection.doc(user.id).update(
          user.toMap(),
        );
  }
}
