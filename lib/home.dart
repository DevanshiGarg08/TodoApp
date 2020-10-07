import 'package:flutter/material.dart';
import 'package:todoapp/tasks.dart';

class App extends StatefulWidget {
  @override
  Home createState() {
    // TODO: implement createState
    return Home();
    throw UnimplementedError();
  }
}

class Home extends State<App> {
  String task;
  List<Tasks> items = [];

  void add(BuildContext context) {
    var alert = AlertDialog(
      // title: Text("Create tasks"),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel")),
        FlatButton(onPressed: () => createTasks(), child: Text("Save"))
      ],

      content: TextFormField(
        onChanged: (value) {
          task = value;
          print(task);
        },
        decoration: InputDecoration(
          labelText: 'Enter your task',
        ),
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void createTasks() {
    Navigator.of(context).pop();
    Tasks todo = Tasks(task, false);
    items.add(todo);
    setState(() {});
    print(items[0]);
  }

  void toggle(Tasks item) {
    item.isCompleted = !item.isCompleted;
    setState(() {});
  }

  void delete(int index) {
    items.removeAt(index);
    setState(() {});
  }

  Widget format(int index) {
    Tasks item = items[index];

    return Card(
        child: ListTile(
          leading: IconButton(
            icon: Icon(item.isCompleted == true
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            color: item.isCompleted == true ? Colors.green : Colors.red,
            onPressed: () {
              toggle(item);
            },
          ),
          title: Text(
            item.name,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: item.isCompleted == true
                    ? TextDecoration.lineThrough
                    : null,
                color: item.isCompleted == true ? Colors.grey : null,
                fontSize: 25.0,
                fontWeight: FontWeight.w400),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 25.0,
            color: Colors.black,
            // padding: EdgeInsets.only(left:190.0),
            onPressed: () {
              delete(index);
            },
          ),
        ),
        elevation: 8.0,
        color: Colors.white,
        margin: EdgeInsets.only(top: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: Icon(
            Icons.calendar_today,
            size: 30.0,
          ),
          title: Text(
            "Todos",
            // textDirection: TextDirection.ltr,
            // textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          )),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return format(index);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add(context);
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
    throw UnimplementedError();
  }
}
