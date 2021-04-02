import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'app.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(PunkApiApp());
}
