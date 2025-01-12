import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterState {
  final int count;

  CounterState({required this.count});
}

class CounterProvider extends ChangeNotifier {
  CounterState _state;

  CounterProvider() : _state = CounterState(count: 0) {
    _loadCounter();
  }

  CounterState get state => _state;

  void increment() {
    _state = CounterState(count: _state.count + 1);
    notifyListeners();
    _saveCounter();
  }

  void decrement() {
    _state = CounterState(count: _state.count - 1);
    notifyListeners();
    _saveCounter();
  }

  Future<void> _loadCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int savedCount = prefs.getInt('counter') ?? 0;
    _state = CounterState(count: savedCount);
    notifyListeners();
  }

  Future<void> _saveCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _state.count);
  }
}
