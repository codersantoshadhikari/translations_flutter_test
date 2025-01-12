import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppLocale extends Equatable {
  final String localeName;
  final String languageCode;

  const AppLocale({required this.localeName, required this.languageCode});

  static List<AppLocale> supportedLocales = [
    const AppLocale(localeName: 'English', languageCode: 'en'),
    const AppLocale(localeName: 'Arabic', languageCode: 'ar'),
    const AppLocale(localeName: 'Nepali', languageCode: 'ne'),
    const AppLocale(localeName: 'Hindi', languageCode: 'hi'),
    const AppLocale(localeName: 'Espanol', languageCode: 'es'),
    const AppLocale(localeName: 'Portugal', languageCode: 'pt'),
    const AppLocale(localeName: 'Le Francais', languageCode: 'fr'),
    const AppLocale(localeName: 'Bahasa Indonesia', languageCode: 'id'),
  ];
  Locale get locale => Locale(languageCode);

  @override
  List<Object?> get props => [
        locale,
      ];
}
