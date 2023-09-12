// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';

class DataFrom extends StatefulWidget {
  const DataFrom({Key? key}) : super(key: key);

  @override
  _DataFromState createState() => _DataFromState();
}

class _DataFromState extends State<DataFrom> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Map<Week, bool> days = {
    Week.monday: false,
    Week.tuesday: false,
    Week.wednesday: false,
    Week.thursday: false,
    Week.friday: false,
    Week.saturday: false,
    Week.sunday: false,
  };
  TimeOfDay? _time;
  Category? _category = Category.work;
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String formatTime(TimeOfDay timetoformat) {
    String min = timetoformat.minute < 10
        ? "0${timetoformat.minute}"
        : "${timetoformat.minute}";
    if (timetoformat.hour > 12) {
      return "${timetoformat.hour - 12}:$min PM";
    }
    return "${timetoformat.hour}:$min AM";
  }

  void _submitForm() {
    bool isDays = false;
    days.forEach((key, value) {
      if (value) {
        isDays = true;
      }
    });
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title is empty"),
        ),
      );
    }
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Description is empty"),
        ),
      );
    }
    if (_time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Time is empty"),
        ),
      );
    }
    if (_category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Category is empty"),
        ),
      );
    }
    if (!isDays) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Days is empty"),
        ),
      );
    }
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _time != null &&
        _category != null &&
        isDays) {
      final Task task = Task(
        id: uuid.v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        time: _time!,
        category: _category!,
        days: days,
      );
      data.add(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Some discription"),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<Category>(
                  value: Category.work,
                  onChanged: (Category? value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  items: Category.values.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(iconCategory[category]),
                          const SizedBox(width: 10.0),
                          Text(category.toString().split('.').last),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Text(_time == null ? "No time choosen" : formatTime(_time!)),
                IconButton(
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _time = time;
                      });
                    }
                  },
                  icon: const Icon(Icons.alarm),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...days.keys.map((Week day) {
                  return Column(
                    children: [
                      Checkbox(
                        value: days[day],
                        onChanged: (bool? value) {
                          setState(() {
                            days[day] = value!;
                          });
                        },
                      ),
                      Text(day.toString().split('.').last.substring(0, 3)),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
