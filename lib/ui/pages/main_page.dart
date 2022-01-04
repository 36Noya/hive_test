import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/model/balance.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    Widget balance(balanceModel) {
      var balanceValue = balanceModel.getAt(0);
      TextEditingController balanceController =
          TextEditingController(text: balanceValue.value.toString());

      return ValueListenableBuilder(
        valueListenable: Hive.box('balance').listenable(),
        builder: (context, box, widget) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Container(
                          alignment: Alignment.center,
                          child: Text('Jumlah'),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Form(
                            child: TextFormField(
                              controller: balanceController,
                              decoration: InputDecoration(
                                labelText: 'Saldo',
                                icon: Icon(Icons.money_sharp),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              balanceModel.putAt(
                                0,
                                Balance(
                                  value: int.parse(balanceController.text),
                                ),
                              );

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(maxWidth * 9 / 10, 50),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Balance: ${balanceValue.value.toString()}',
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(maxWidth * 9 / 10, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: Hive.openBox('balance'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              var balanceModel = Hive.box('balance');
              if (balanceModel.length == 0) {
                balanceModel.add(Balance(value: 0));
              }

              return balance(balanceModel);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
