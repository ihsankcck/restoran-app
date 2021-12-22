import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:restoran/screens/home.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>
    with AutomaticKeepAliveClientMixin<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  static const TextInputType phoneNumberType = TextInputType.phone;
  static const TextInputType nameType = TextInputType.text;
  final values = {};
  String dropdownValue = 'Masa 1';
  List<String> tables = ['Masa 1', 'Masa 2', 'Masa 3', 'Masa 4'];
  EdgeInsets formMargin =
      const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20.0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservazyon oluştur"),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: formMargin,
                    child: TextFormField(
                      keyboardType: nameType,
                      autofocus: true,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), labelText: 'İsminiz'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen ismiminizi giriniz!';
                        }
                        values['name'] = value;
                      },
                    ),
                  ),
                  Container(
                    margin: formMargin,
                    child: TextFormField(
                      keyboardType: phoneNumberType,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Telefon numarası'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen telefon numaranızı giriniz!';
                        }
                        values['phone'] = value;
                      },
                    ),
                  ),
                  Container(
                    margin: formMargin,
                    child: DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'd MMMM, yyyy - hh:mm a',
                      initialValue: currentDate.toString(),
                      firstDate: DateTime(
                          currentDate.year,
                          currentDate.month,
                          currentDate.day,
                          currentDate.hour,
                          currentDate.minute,
                          0,
                          0,
                          0),
                      lastDate: DateTime(
                          currentDate.year,
                          currentDate.month + 1,
                          currentDate.day,
                          currentDate.hour,
                          currentDate.minute,
                          0,
                          0,
                          0),
                      dateLabelText: 'Rezervasyon tarihi',
                      onChanged: (value) => print(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen rezervasyon tarihi seçiniz!';
                        }
                        values['dateTime'] = value;
                      },
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        values['table'] = newValue;
                      });
                    },
                    items: tables.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        tooltip: "Reservasyon oluştur",
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            print(values);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rezervasyonunuz Kaydediliyor.')),
            );

            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Rezervasyonunuz kaydedilmiştir'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const HomeScreen();
                        },
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: const Icon(
          Icons.send,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
