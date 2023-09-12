import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
// formater for hours and minutes
final DateFormat formatter = DateFormat.Hm();

class Task {
  final String id;
  final String title;
  final String description;
  final Category category;
  final TimeOfDay time;
  bool isDone = false;
  Map<Week, bool> days;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.time,
    required this.days,
  });

  String get getTimeString {
    return "${time.hour}:${time.minute}";
  }
}

List<Task> data = [
  Task(
    id: uuid.v4(),
    title: "task1",
    description: "description1",
    category: Category.shopping,
    time: TimeOfDay.now(),
    days: {Week.monday: true},
  ),
  Task(
    id: uuid.v4(),
    title: "task2",
    description: "description2",
    category: Category.others,
    time: TimeOfDay.now(),
    days: {Week.sunday: true},
  ),
];

List<Task> getdata() {
  return data;
}

enum Category { work, personal, shopping, others }

enum Week { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

const weekCategory = {
  "Monday": Week.monday,
  "Tuesday": Week.tuesday,
  "Wednesday": Week.wednesday,
  "Thursday": Week.thursday,
  "Friday": Week.friday,
  "Saturday": Week.saturday,
  "Sunday": Week.sunday,
};

const iconCategory = {
  Category.work: Icons.work,
  Category.personal: Icons.person,
  Category.shopping: Icons.shopping_cart,
  Category.others: Icons.label_important_outline_sharp,
};
