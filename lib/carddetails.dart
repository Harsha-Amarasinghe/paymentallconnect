import 'package:flutter/material.dart';
import 'package:paymentallconnect/fail.dart';
import 'package:paymentallconnect/receipt.dart';
import 'package:paymentallconnect/success.dart';
import 'package:paymentallconnect/MainDrawer.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({Key? key}) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  TextEditingController name = new TextEditingController();
  TextEditingController card_num = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController date = new TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool status = false;

  var child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
        centerTitle: true,
        backgroundColor: Color(0XFF128C7E),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Checkbox(
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.green,
                ),
                Text("Visa"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.green,
                ),
                Text("Master Card"),
              ],
            ),
            TextField(
                controller: name,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name on Card',
                  //labelStyle: TextStyle(color: Colors.black)),
                )),
            TextField(
                controller: card_num,
                decoration: InputDecoration(
                  icon: Icon(Icons.format_list_numbered_rtl_outlined),
                  labelText: 'Card Number',
                  //labelStyle: TextStyle(color: Colors.black)),
                )),
            TextField(
                controller: amount,
                decoration: InputDecoration(
                  icon: Icon(Icons.money),
                  labelText: 'Amount',
                  //labelStyle: TextStyle(color: Colors.black)),
                )),
            DateTimePicker(
              controller: date,
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.calendar_today),
              dateLabelText: 'Expiration Date',
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black),
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Pay"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "field1": name.text,
                      "field2": card_num.text,
                      "field3": amount.text,
                      "field4": date.selection
                    };
                    FirebaseFirestore.instance.collection("test").add(data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SucessPayment()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  onItemClicked(CheckBoxModel ckbItem) {
    setState(() {
      ckbItem.value = !ckbItem.value;
    });
  }
}

class CheckBoxModel {
  String title;
  bool value;

  CheckBoxModel({required this.title, this.value = false});
}
