import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = '';
const supabaseKey = '';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const App());
}

