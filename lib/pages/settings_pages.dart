import 'package:flutter/material.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListTile(
        title: const Text('Temperature Unit'),
        subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
        trailing: Switch(value: context.watch<TempSettingsProvider>().state.tempUnit == TempUnit.celsius,
        onChanged: (_) {
          context.read<TempSettingsProvider>().tongleTempUnit();
        },),
      )
    );
  }
}
