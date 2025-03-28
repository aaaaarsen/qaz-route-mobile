import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://nprwbqrwqxeidvjxulbo.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcndicXJ3cXhlaWR2anh1bGJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2Njk0OTksImV4cCI6MjA1NjI0NTQ5OX0.ATvP8OU5DlQsoAu0KiiV1Z5nY2f4sw6VwEa8i-DO8LM';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const App());
}

