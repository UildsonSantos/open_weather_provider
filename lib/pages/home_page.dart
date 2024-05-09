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
  late final WeatherProvider _weatherProv;

  void _registerListener() {
    final WeatherState ws = context.read<WeatherProvider>().state;

    if (ws.status == WeatherStatus.error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(ws.error.errMsg),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _weatherProv = context.read<WeatherProvider>();
    _weatherProv.addListener(_registerListener);
  }

  @override
  void dispose() {
    _weatherProv.removeListener(_registerListener);
    super.dispose();
  }

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
        body: _showWeather());
  }

  Widget _showWeather() {
    final state = context.watch<WeatherProvider>().state;

    if (state.status == WeatherStatus.initial) {
      return const Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }

    if (state.status == WeatherStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.status == WeatherStatus.error && state.weather.name == '') {
      return const Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }
    return Center(
      child: Text(
        state.weather.name,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}
