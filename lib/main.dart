// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:date_format/date_format.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:tapzy/src/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}





























































//Firebase


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message)async  {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  print("In background message wohooo!");
  debugPrint("Handling the message in the background");

  // Or do other work.
}
//
//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final _firebaseMessaging = FirebaseMessaging();
//
//   String _message = "Not got message";
//   String _token = "Token";
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//
//
//
//     _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           print('on message $message');
//           setState(() => _message = '$message');
//         },
//         onBackgroundMessage: myBackgroundMessageHandler,
//
//         onResume: (Map<String, dynamic> message) async {
//       print('on resume $message');
//       setState(() => _message = '$message');
//     },
//
//         onLaunch: (Map<String, dynamic> message) async {
//       print('on launch $message');
//       setState(() => _message = '$message');
//     });
//
//     _firebaseMessaging.getToken().then((String token) {
//       assert(token!=null);
//       setState(() {
//         _token='$token';
//       });
//       print(token);
//     });
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       theme: ThemeData.dark(),
//        home:FirebaseRealtimeDemoScreen()
//       // home: Scaffold(
//       //   body: Container(
//       //     child: Center(
//       //       child: Column(
//       //         children: [
//       //           Text(_token),
//       //           Divider(),
//       //           Text(_message)
//       //         ],
//       //       ),
//       //     ),
//       //   ),
//       // )
//     );
//   }
//
//
//
// }
//
//
//
// class FirebaseRealtimeDemoScreen extends StatefulWidget {
//
//   @override
//   _FirebaseRealtimeDemoScreenState createState() =>
//       _FirebaseRealtimeDemoScreenState();
// }
//
// class _FirebaseRealtimeDemoScreenState
//     extends State<FirebaseRealtimeDemoScreen> {
//   final databaseReference = FirebaseDatabase.instance.reference();
//
//   var name1 = "Akshar";
//   var time = DateTime.now().toString();
//   var minutes = "99";
//
//   String _hour, _minute, _time;
//
//   TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
//   TextEditingController _timeController = TextEditingController();
//
//
//   Future<Null> _selectTime(BuildContext context) async {
//     final TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null)
//       setState(() {
//         selectedTime = picked;
//         _hour = selectedTime.hour.toString();
//         _minute = selectedTime.minute.toString();
//         _time = _hour + ' : ' + _minute;
//         _timeController.text = _time;
//         _timeController.text = formatDate(
//             DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
//             [hh, ':', nn, " ", am]).toString();
//       });
//     time = _timeController.text;
//   }
//
//   @override
//   void initState() {
//     _timeController.text = formatDate(
//         DateTime(2019, 08, 1, DateTime
//             .now()
//             .hour, DateTime
//             .now()
//             .minute),
//         [hh, ':', nn, " ", am]).toString();
//
//     databaseReference
//         .child('user1')
//         .onValue
//         .listen((event) {
//       var snapshot = event.snapshot;
//       this.name1 = snapshot.value['user1']['name'];
//       print('Value is $name1');
//     });
//     if (this.name1 == "Hey") {
//       print("Realtime Update");
//     }
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     readData();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Realtime Database Demo'),
//       ),
//       body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//
//                 RaisedButton(
//                   child: Text('Create Data'),
//                   color: Colors.redAccent,
//                   onPressed: () async {
//                     await createData().then((value) =>
//                     Flushbar(
//                       title: "Hey Akshar",
//                       message: "Data Created",
//                       backgroundColor: Colors.red,
//                       duration: Duration(seconds: 2),
//                       boxShadows: [BoxShadow(color: Colors.red[800],
//                         offset: Offset(0.0, 2.0),
//                         blurRadius: 3.0,)
//                       ],
//                     )
//                       ..show(context));
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//                 ),
//                 SizedBox(height: 8,),
//                 RaisedButton(
//                   child: Text('Read/View Data'),
//                   color: Colors.redAccent,
//
//                   onPressed: () async {
//                     await readData().then((value) =>
//                     Flushbar(
//                       title: "Hey Akshar",
//                       message: "Name=${name1} Time=${time} Minutes=${minutes}",
//                       backgroundColor: Colors.red,
//                       duration: Duration(seconds: 2),
//                       boxShadows: [BoxShadow(color: Colors.red[800],
//                         offset: Offset(0.0, 2.0),
//                         blurRadius: 3.0,)
//                       ],
//                     )
//                       ..show(context));
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//
//                 ),
//                 SizedBox(height: 8,),
//
//                 RaisedButton(
//                   child: Text('Update Data'),
//                   color: Colors.redAccent,
//
//                   onPressed: () async {
//                     await updateData().then((value) =>
//                     Flushbar(
//                       title: "Hey Akshar",
//                       message: "Data is Updated",
//                       backgroundColor: Colors.red,
//                       duration: Duration(seconds: 2),
//                       boxShadows: [BoxShadow(color: Colors.red[800],
//                         offset: Offset(0.0, 2.0),
//                         blurRadius: 3.0,)
//                       ],
//                     )
//                       ..show(context));
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//
//                 ),
//                 SizedBox(height: 8,),
//
//                 RaisedButton(
//                   child: Text('Delete Data'),
//                   color: Colors.redAccent,
//
//                   onPressed: () async {
//                     await deleteData().then((value) =>
//                     Flushbar(
//                       title: "Hey Akshar",
//                       message: "Data is Deleted",
//                       backgroundColor: Colors.red,
//                       duration: Duration(seconds: 2),
//                       boxShadows: [BoxShadow(color: Colors.red[800],
//                         offset: Offset(0.0, 2.0),
//                         blurRadius: 3.0,)
//                       ],
//                     )
//                       ..show(context));
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//
//                 ),
//
//                 RaisedButton(
//                   child: Text(_timeController.text),
//                   onPressed: () =>
//                   {
//                     _selectTime(context)
//                   },
//                 ),
//                 Card(
//                   child: Container(
//                     padding: EdgeInsets.all(32.0),
//                     child: Column(
//                       children: <Widget>[
//                         Text('Name: $name1'),
//                         Text('Time:$time'),
//                         Text('Total minutes:$minutes'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//       ), //center
//     );
//   }
//
//   Future<void> createData() async {
//     databaseReference.child("user1").set({
//       'name': 'Akshar',
//       'time': '17:09 PM',
//       'minutes': '60'
//     });
//   }
//
//   Future<void> updateData() async {
//     databaseReference.child('user1').update({
//       'name': 'Akshar Patel',
//       'time': _timeController.text,
//       'minutes': '17'
//     });
//   }
//
//   Future<void> readData() async {
//     databaseReference.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//       var map = snapshot.value;
//       print(map['user1']['name'].toString());
//
//
//       setState((){
//         this.name1 = map['user1']['name'].toString();
//         this.time = map['user1']['time'].toString();
//         this.minutes = map['user1']['minutes'].toString();
//       });
//     });
//   }
//
//   Future<void> deleteData() async {
//     databaseReference.child('user1').remove();
//   }
// }