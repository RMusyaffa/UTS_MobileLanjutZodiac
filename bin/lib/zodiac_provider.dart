// lib/models/zodiac_provider.dart
import 'package:flutter/material.dart';
import 'zodiac.dart';

class ZodiacProvider extends ChangeNotifier {
  String _name = '';
  DateTime? _selectedDate;
  Zodiac? _zodiac;

  String get name => _name;
  DateTime? get selectedDate => _selectedDate;
  Zodiac? get zodiac => _zodiac;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _determineZodiac(date);
    notifyListeners();
  }

  void _determineZodiac(DateTime date) {
    int month = date.month;
    int day = date.day;

    if ((month == 12 && day >= 21) || (month == 1 && day <= 19)) {
      _zodiac = Zodiac.capricorn;
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      _zodiac = Zodiac.aquarius;
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      _zodiac = Zodiac.pisces;
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 20)) {
      _zodiac = Zodiac.aries;
    } else if ((month == 4 && day >= 21) || (month == 5 && day <= 20)) {
      _zodiac = Zodiac.taurus;
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      _zodiac = Zodiac.gemini;
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 20)) {
      _zodiac = Zodiac.cancer;
    } else if ((month == 7 && day >= 21) || (month == 8 && day <= 21)) {
      _zodiac = Zodiac.leo;
    } else if ((month == 8 && day >= 22) || (month == 9 && day <= 22)) {
      _zodiac = Zodiac.virgo;
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      _zodiac = Zodiac.libra;
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 22)) {
      _zodiac = Zodiac.scorpio;
    } else if ((month == 11 && day >= 23) || (month == 12 && day <= 20)) {
      _zodiac = Zodiac.sagittarius;
    }
  }
}