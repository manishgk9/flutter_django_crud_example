import 'package:flutter/material.dart';
import 'package:futter_django_crud_example/pages/home.dart';

void main() {
  return runApp(const MaterialApp(
    title: 'Crud Demo',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
