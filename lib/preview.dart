import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() => runApp(
  DevicePreview(
    builder: (context) => PunkApiApp(), // Wrap your app
  ),
);