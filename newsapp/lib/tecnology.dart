import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Tecnologypage extends StatefulWidget {
  const Tecnologypage({Key? key}) : super(key: key);

  @override
  _TecnologypageState createState() => _TecnologypageState();
}

class _TecnologypageState extends State<Tecnologypage> {
  late Future<List> data;

  @override
  void initState() {
    super.initState();
    data = fetchnews();
  }

  Future<void> _launchURL(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Cannot launch the url');
    }
  }

  Future<List> fetchnews() async {
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey',
      ),
    );
    final result = jsonDecode(response.body);
    return result['articles'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News app',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [Icon(Icons.notifications_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List>(
          future: data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final articles = snapshot.data!;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final url = articles[index]['url'];

                return Column(
                  children: [
                    InkWell(
                      onTap: () => _launchURL(url),
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              articles[index]['urlToImage'] ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      articles[index]['title'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Divider(thickness: 2),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
