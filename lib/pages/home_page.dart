import 'package:flutter/material.dart';
import 'package:open_weather_provider/pages/pages.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final weatherContext = context.read<WeatherProvider>();

              _city = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SearchPage();
                },
              ));

              if (_city != null) {
                weatherContext.fetchWeather(_city!);
              }
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Home page'),
      ),
    );
  }
}
