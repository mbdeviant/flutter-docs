import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  final String title;
  final String body;

  Data({required this.title, required this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      body: json['body'],
    );
  }
}

class DataCubit extends Cubit<List<Data>> {
  DataCubit() : super([]);

  Future<void> fetchData() async {
    try {
      final res = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;
        emit(data.map((item) => Data.fromJson(item)).toList());
      } else {
        throw Exception('couldnt fetch data');
      }
    } catch (e) {
      throw Exception('couldnt fetch data');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC'),
        ),
        body: BlocProvider(
          create: (context) => DataCubit(),
          child: const DataListView(),
        ),
      ),
    );
  }
}

class DataListView extends StatelessWidget {
  const DataListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataCubit = context.read<DataCubit>();
    dataCubit.fetchData();

    return BlocBuilder<DataCubit, List<Data>>(
      builder: (context, dataList) {
        if (dataList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataList[index].title),
                subtitle: Text(dataList[index].body),
              );
            },
          );
        }
      },
    );
  }
}
