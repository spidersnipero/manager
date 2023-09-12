import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/data_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addTask() async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) => const DataFrom(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Life"),
        actions: [
          IconButton(
              onPressed: () {
                _addTask();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                bool ch = data[index].days[weekCategory[
                            DateFormat('EEEE').format(DateTime.now())]] !=
                        null &&
                    data[index].days[weekCategory[
                        DateFormat('EEEE').format(DateTime.now())]]!;
                if (ch) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onLongPress: () => setState(
                        () {
                          data[index].isDone = true;
                        },
                      ),
                      onTap: () => setState(() {
                        data[index].isDone = false;
                      }),
                      leading: Icon(iconCategory[data[index].category]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      tileColor: data[index].isDone
                          ? const Color.fromARGB(153, 0, 154, 18)
                          : const Color.fromRGBO(1, 105, 165, 0.6),
                      contentPadding: const EdgeInsets.all(12.0),
                      title: Text(data[index].title),
                      subtitle: Text(data[index].description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(data[index].isDone
                              ? Icons.done
                              : Icons.access_time_filled_sharp),
                          const SizedBox(width: 7.0),
                          Text(
                            data[index].getTimeString,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
