import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class Data {
  final String title;
  final String text;

  Data({required this.title, required this.text});
}

class DataProvider with ChangeNotifier {
  List<Data> _data = [];

  List<Data> get data => _data;

  Future<void> fetchData() async {
    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (res.statusCode == 200) {
      final List<dynamic> incomingData = json.decode(res.body);

      _data = incomingData
          .map((data) => Data(title: data['title'], text: data['body']))
          .toList();
      notifyListeners();
    } else {
      throw Exception('couldnt fetch data');
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('data list'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: dataProvider.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataProvider.data[index].title),
                  subtitle: Text(dataProvider.data[index].text),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              dataProvider.fetchData();
            },
            child: const Text('fetch data'),
          )
        ]),
      ),
    );
  }
}
