import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _numberField = TextEditingController();
  double _textScaleFactor;
  Icon callTypeIcon(CallType myCallType) {
    switch (myCallType) {
      case CallType.answeredExternally:
        {
          return Icon(Icons.call_received);
        }
        break;
      case CallType.blocked:
        {
          return Icon(Icons.android);
        }
        break;
      case CallType.incoming:
        {
          return Icon(Icons.android);
        }
        break;
      case CallType.missed:
        {
          return Icon(Icons.call_missed);
        }
        break;
      case CallType.outgoing:
        {
          return Icon(Icons.android);
        }
        break;
      case CallType.rejected:
        {
          return Icon(Icons.android);
        }
        break;
      case CallType.unknown:
        {
          return Icon(Icons.android);
        }
        break;
      case CallType.voiceMail:
        {
          return Icon(Icons.android);
        }
        break;

      default:
        {
          return Icon(Icons.call);
        }
        break;
    }
  }

  List myNumber = [];

  Future<List<CallLogEntry>> getCallLogs() async {
    List<CallLogEntry> entries = (await CallLog.get()).toList();
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    _textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return FutureBuilder(
      future: getCallLogs(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                  itemCount: (snapshot.data as List<CallLogEntry>).length,
                  itemBuilder: (ctx, i) {
                    CallLogEntry callLogs =
                        (snapshot.data as List<CallLogEntry>)[i];
                    print('duration${callLogs.duration}');

                    return ListTile(
                      leading: callTypeIcon(callLogs.callType),
                      title: Text(
                        callLogs?.name != null
                            ? callLogs.name
                            : callLogs.formattedNumber,
                      ),
                      subtitle: Text(
                        callLogs.formattedNumber,
                        style: TextStyle(color: Colors.black45),
                      ),
                      trailing: Text(
                        ' ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(callLogs.timestamp))}',
                        style: TextStyle(
                            fontSize: _textScaleFactor * 12,
                            color: Colors.black38),
                      ),
                    );
                  }),
              Container(
                child: Column(
                  children: [
                    Spacer(),
                    NeumorphicFloatingActionButton(
                        style: NeumorphicStyle(
                          color: Colors.greenAccent,
                          shape: NeumorphicShape.convex,
                        ),
                        child: Icon(
                          Icons.dialpad,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              barrierColor: Colors.black.withOpacity(0.0),
                              backgroundColor: Colors.white.withOpacity(0.0),
                              builder: (ctx) => Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.greenAccent
                                                      .withOpacity(0.1),
                                                  Colors.white
                                                ]),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        height: (mediaQuery.height / 2) + 300,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                child: TextField(
                                                  controller: _numberField,
                                                  textAlign: TextAlign.center,
                                                  readOnly: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize:
                                                          _textScaleFactor *
                                                              24),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      fillColor: Colors.blue,
                                                      suffix: IconButton(
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            myNumber.clear();
                                                            _numberField
                                                                .clear();
                                                          });
                                                        },
                                                      )),
                                                ),
                                                height: 30,
                                              ),
                                              Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    numberWidget(
                                                        myNum: '1',
                                                        subAlphabet: 'o_o'),
                                                    numberWidget(
                                                        myNum: '2',
                                                        subAlphabet: 'ABC'),
                                                    numberWidget(
                                                        myNum: '3',
                                                        subAlphabet: 'DEF')
                                                  ]),
                                              Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    numberWidget(
                                                        myNum: '4',
                                                        subAlphabet: 'GHI'),
                                                    numberWidget(
                                                        myNum: '5',
                                                        subAlphabet: 'JKL'),
                                                    numberWidget(
                                                        myNum: '6',
                                                        subAlphabet: 'MNO')
                                                  ]),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  numberWidget(
                                                      myNum: '7',
                                                      subAlphabet: 'PQRS'),
                                                  numberWidget(
                                                      myNum: '8',
                                                      subAlphabet: 'TUV'),
                                                  numberWidget(
                                                      myNum: '9',
                                                      subAlphabet: 'WXYZ')
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  numberWidget(
                                                      myNum: '⁕',
                                                      subAlphabet: ','),
                                                  numberWidget(
                                                      myNum: '0',
                                                      subAlphabet: '+'),
                                                  numberWidget(
                                                      myNum: '#',
                                                      subAlphabet: ';')
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  NeumorphicFloatingActionButton(
                                                    style: NeumorphicStyle(
                                                        color:
                                                            Colors.greenAccent,
                                                        shape: NeumorphicShape
                                                            .convex,
                                                        boxShape:
                                                            NeumorphicBoxShape
                                                                .circle()),
                                                    child: Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () async {
                                                      FlutterPhoneDirectCaller
                                                          .callNumber(
                                                              myNumber.join());
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )).then((_) {
                            _numberField.clear();
                            myNumber.clear();
                          });
                        }),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          );
        }
        return Center(child: Lottie.asset('assets/dance_loading.json'));
      },
    );
  }

  InkWell numberWidget(
          {@required String myNum, @required String subAlphabet}) =>
      InkWell(
        radius: 40,
        focusColor: Colors.green,
        splashColor: Colors.greenAccent,
        autofocus: true,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            children: [
              Text(
                myNum,
                style: TextStyle(fontSize: _textScaleFactor * 25),
              ),
              Text(
                subAlphabet,
                style: TextStyle(
                    fontSize: _textScaleFactor * 15, color: Colors.black45),
              )
            ],
          ),
        ),
        onTap: () {
          myNumber.add(myNum);
          _numberField.text = myNumber.join();

          print(myNumber);
        },
      );
}
