import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Sportswidget extends StatefulWidget {
  const Sportswidget({Key? key}) : super(key: key);

  @override
  _SportswidgetState createState() => _SportswidgetState();
}

class _SportswidgetState extends State<Sportswidget> {
  late Future<List> data;

  @override
  void initState() {
    super.initState();
    data = fetchnews();
  }

  _launchURL(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Cannot launch the url');
    }
  }

  Future<List> fetchnews() async {
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=11a88b5bf6004aa0868f1e5c91984998',
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
        actions: [
          InkWell(
            onTap: () {
              print('Notifications');
            },
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
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
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final url = articles[index]['url'];

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL(url);
                      },

                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 400,
                        width: 300,

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
                    SizedBox(height: 8),
                    Text(
                      articles[index]['title'] ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
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
