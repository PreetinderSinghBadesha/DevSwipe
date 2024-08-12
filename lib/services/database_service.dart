import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobify/models/user_model.dart';

const String USER_COLLECTION_REF = "Users";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _userRef;

  DatabaseService() {
    _userRef =
        _firestore.collection(USER_COLLECTION_REF).withConverter<UserModel>(
            fromFirestore: (snapshots, _) => UserModel.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (user, _) => user.toJson());
  }

  Stream<DocumentSnapshot<UserModel>> getUserDetails(String userId) {
    return _userRef
        .doc(userId)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots();
  }

  void addUser(UserModel userdetails, User? user) async {
    await _userRef.doc(user!.uid).set(userdetails);
  }
}