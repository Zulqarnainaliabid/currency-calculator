import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; //for initialization
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //------Firebase integration----

  await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform;
    options: const FirebaseOptions(
        apiKey: "AIzaSyCaL1pEy4iFT_3jW6iHu2N6c_xZ-mMVghI",
        appId: "1:872756273255:android:155a12ca8a056e09e334c2", //
        messagingSenderId: "872756273255",
        projectId: "currencycalc-19909", //
        storageBucket: "currencycalc-19909.appspot.com"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Insert data"),
              onPressed: () {
                insertdataUsingAdd();
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Update data"),
              onPressed: () {
                UpdateData();
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Get data"),
              onPressed: () {
                getdata();
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Delete data"),
              onPressed: () {
                DeleteData();
              },
            ),
          ],
        ),
      ),
    );
  }

  void UpdateData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc("W5jNA8cNnbopVImZpcGS")
        .update({"name": "Farhan", "age": "55"}).then((value) {
      print("Successfully record updated");
    }).catchError((error) {
      print("Error during update. $error");
    });
  }

  void getdata() async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc("dxgiXnYm6qTb4zTnF0e6")
        .get();
    Map<String, dynamic>? data = docSnapshot.data();
    print(data);
  }

  void insertdataUsingAdd() async {
    await FirebaseFirestore.instance.collection("users").add({
      "name": "john",
      "age": '50',
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print("Successfully record added");
    }).catchError((error) {
      print("Error during new record add. $error");
    });
  }

  void DeleteData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    collection.doc('W5jNA8cNnbopVImZpcGS').delete().then((value) {
      print("Successfully record deleted");
    }).catchError((error) {
      print("Error during delete record $error");
    });
  }
}
