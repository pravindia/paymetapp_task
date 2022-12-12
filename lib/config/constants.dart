import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

var currencyFormater = NumberFormat.currency(
  locale: Platform.localeName,
  symbol: '',
  customPattern: '\u20B9 #,###',
  decimalDigits: 2,
);

var dateformter = DateFormat.yMd().add_jm();

const floatingActionAdd = Key('floatingActionAdd');
const featuredCardKey = Key('featuredCardKey');
const footerText = Key('footerText');
const profilePageNav = Key('profilePageNav');

const String domain = "api.storerestapi.com";
