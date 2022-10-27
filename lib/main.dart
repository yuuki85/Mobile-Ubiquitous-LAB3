import 'package:flutter/material.dart';
import 'package:form_navigation/RateCourse.dart';

// function to trigger build when the app is run
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/second': (context) => const MenuTutorail(),
      '/third': (context) => const FormValidate(),
    },
  )); //MaterialApp
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Information'),
        backgroundColor: Colors.blueAccent,
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Exploring Course!'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
            ), // ElevatedButton
            ElevatedButton(
              child: const Text('Semester Course Works!'),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
            ), // ElevatedButton
          ], // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

class MenuTutorail extends StatelessWidget {
  const MenuTutorail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exploring Course"),
        actions: appBarActions(context),
      ),
    );
  }

  List<Widget> appBarActions(BuildContext context) {
    return [
      PopupMenuButton<String>(
        itemBuilder: (_) {
          return const [
            PopupMenuItem<String>(value: "1", child: Text("Rate Course")),
            PopupMenuItem<String>(value: "2", child: Text("Course Timer")),
            PopupMenuItem<String>(value: "3", child: Text("Course Planner")),
            PopupMenuItem<String>(value: "4", child: Text("Course Date")),
            PopupMenuItem<String>(value: "5", child: Text("Exit")),
          ];
        },
        icon: const Icon(Icons.account_circle),
        onSelected: (i) {
          if (i == "1") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RateCourse()));
          } else if (i == "2") {
            displayBar(context, i);
          } else if (i == "3") {
            displayBar(context, i);
          } else if (i == "4") {
            displayBar(context, i);
          } else if (i == "5") {
            displayBar(context, i);
          } else {}
        },
        onCanceled: () => displayBar(context, "Cancelled", cancel: true),
      ),
    ];
  }

  dynamic displayBar(BuildContext context, String text, {bool cancel = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: !cancel ? Text("Click Item $text") : Text(text)));
  }
}

class FormValidate extends StatefulWidget {
  const FormValidate({Key? key}) : super(key: key);
  @override
  State<FormValidate> createState() => _FormValidateState();
}

class _FormValidateState extends State<FormValidate> {
  List<Widget> list = [];
  int fieldCount = 0;
  List<Map<String, dynamic>> items = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Course Works"),
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.tab_rounded),
            ),
            onTap: () => itinerariesDialog(context),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            fieldCount == 0
                ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No CourseWorks!",
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) => buildField(i),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Add CourseWorks")));
                            }
                          },
                          child: const Text("Submit")),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("ADD\nNEW"),
        onPressed: () {
          setState(() {
            fieldCount++;
            list.add(buildField(fieldCount));
          });
        },
      ),
    );
  }

  itinerariesDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Course Works"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: items.map((e) => Text(e["TodoList"].trim())).toList(),
              ),
            ),
          );
        });
  }

  Widget buildField(int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text((i + 1).toString()),
      ),
      title: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "TodoList ${i + 1}",
        ),
        onChanged: (data) => storeValue(i + 1, data),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
      trailing: InkWell(
        child: const Icon(Icons.delete_outlined, color: Colors.red),
        onTap: () {
          setState(() {
            fieldCount--;
            list.removeAt(i);
            items.removeAt(i);
          });
        },
      ),
    );
  }

  dynamic storeValue(int i, String v) {
    bool valueFound = false;
    for (int j = 0; j < items.length; j++) {
      if (items[j].containsKey("field_id")) {
        if (items[j]["field_id"] == i) {
          valueFound = !valueFound;
          break;
        }
      }
    }

    /// If value is found
    if (valueFound) {
      items.removeWhere((e) => e["field_id"] == i);
    }
    items.add({
      "field_id": i,
      "TodoList": v,
    });
  }
}
