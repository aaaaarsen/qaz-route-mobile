import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

const supabaseUrl = 'https://nprwbqrwqxeidvjxulbo.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcndicXJ3cXhlaWR2anh1bGJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2Njk0OTksImV4cCI6MjA1NjI0NTQ5OX0.ATvP8OU5DlQsoAu0KiiV1Z5nY2f4sw6VwEa8i-DO8LM';
const mapboxKey = 'pk.eyJ1Ijoic2tlZXJjZyIsImEiOiJjbTh0N2diMXAwNjd5MmpyMWc2Y3d1bHR1In0.2tMAl3LyD8x82LV0-fNhLA';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  MapboxOptions.setAccessToken(mapboxKey);

  runApp(const App());
}

