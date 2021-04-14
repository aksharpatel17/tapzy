// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:date_format/date_format.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapzy/src/HomeScreen.dart';
import 'package:tapzy/src/Widget/bezierContainer.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:tapzy/src/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';


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
    return
      MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseRealtimeDemoScreen(),
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
class FirebaseRealtimeDemoScreen extends StatefulWidget {

  @override
  _FirebaseRealtimeDemoScreenState createState() =>
      _FirebaseRealtimeDemoScreenState();
}

class _FirebaseRealtimeDemoScreenState
    extends State<FirebaseRealtimeDemoScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController _textEditingController = new TextEditingController();

  var name1 = "Akshar";
  var time = DateTime.now().toString();
  var minutes = "";
  var isEnabled=true;

  String _hour, _minute, _time;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();


  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    time = _timeController.text;
  }

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime
            .now()
            .hour, DateTime
            .now()
            .minute),
        [hh, ':', nn, " ", am]).toString();

    databaseReference
        .child('user1')
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      this.name1 = snapshot.value['user1']['name'];
      print('Value is $name1');
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    readData();
    return Scaffold(

        resizeToAvoidBottomPadding:false,
      body: Stack(
        children:<Widget>[
          Positioned(top: 40, left: 0, child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                    child: Icon(Icons.logout, color: Color(0xff3a7bd5)),
                  ),
                  Text('Logout',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
          ),
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
        Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .08),
              RichText(
              textAlign: TextAlign.center,
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: 'Tap',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      TextSpan(
                        text: 'zy',
                        style: TextStyle(color: Color(0xff3a7bd5), fontSize: 30),
                      ),
                    ]),
              ),

                  SizedBox(height: height * .08),
                  InkWell(
                    onTap: () =>
                    {
                      _selectTime(context)
                    } ,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xff00d2ff), Color(0xff3a7bd5)])),
                      child: Text(
                        _timeController.text,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  TextField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    showCursor: false,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter Time Duration",
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color:Color(0xff3a7bd5)),

                    ),
                  ),
                  SizedBox(height: height * .01),
                  SwitchListTile(
                    title: const Text('Tap'),
                    activeColor: Color(0xff3a7bd5),
                    value: isEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isEnabled = value;
                      });
                    },
                    secondary: const Icon(Icons.water_damage),
                  ),InkWell(
                    onTap: () async {
                      await createData().then((value) =>
                      Flushbar(
                        title: "Hey Akshar",
                        message: "Data Created",
                        backgroundColor: Color(0xff3a7bd5),
                        duration: Duration(seconds: 2),

                      )
                        ..show(context));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xff00d2ff), Color(0xff3a7bd5)])),
                      child: Text(
                        'Create Data',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: height * .03),
                  InkWell(
                    onTap: () async {
                      await readData().then((value) =>
                      Flushbar(
                        title: "Hey Akshar",
                        message: "Name=${name1} Time=${time} Minutes=${minutes}",
                        backgroundColor: Color(0xff3a7bd5),
                        duration: Duration(seconds: 2),

                      )
                        ..show(context));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 13),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Color(0xff3a7bd5), width: 2),
                      ),
                      child: Text(
                        'Read Data',
                        style: TextStyle(fontSize: 20, color: Color(0xff3a7bd5)),
                      ),
                    ),
                  ),


                  SizedBox(height: height * .03),





                ],
              ),
            )
        )
        ]
      ),
      //center
    );
  }

  Future<void> createData() async {
    databaseReference.child("user1").set({
      'name': 'Akshar',
      'time':  _timeController.text,
      'minutes': _textEditingController.text,
      'isEnabled':isEnabled
    });
  }

  Future<void> updateData() async {
    databaseReference.child('user1').update({
      'name': 'Akshar Patel',
      'time': _timeController.text,
      'minutes': '17'
    });
  }

  Future<void> readData() async {
    databaseReference.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      var map = snapshot.value;
      // print(map['user1']['name'].toString());


      setState((){
        this.name1 = map['user1']['name'].toString();
        this.time = map['user1']['time'].toString();
        this.minutes = map['user1']['minutes'].toString();
      });
    });
  }

  Future<void> deleteData() async {
    databaseReference.child('user1').remove();
  }
}