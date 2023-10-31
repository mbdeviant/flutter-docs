import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ApiCall {
  Future<List<Data>> fetchData() async {
    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List<dynamic>;
      return data.map((item) => Data.fromJson(item)).toList();
    } else {
      throw Exception('couldnt fetch data');
    }
  }
}

final apiCallProvider = Provider<ApiCall>((ref) => ApiCall());

final dataListProvider = FutureProvider<List<Data>>((ref) async {
  final apiCall = ref.read(apiCallProvider);
  return await apiCall.fetchData();
});

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('riverpod'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final dataList = ref.watch(dataListProvider);

            return dataList.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].title),
                        subtitle: Text(data[index].body),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  return Center(
                    child: Text(error.toString()),
                  );
                });
          },
        ),
      ),
    );
  }
}
