import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:futter_django_crud_example/requests/fetch.dart';
import 'package:futter_django_crud_example/requests/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Student>> fetchData;
  final TextEditingController _namefield = TextEditingController();
  final TextEditingController _adressfield = TextEditingController();
  final TextEditingController _phonefield = TextEditingController();
  final TextEditingController _namefield1 = TextEditingController();
  final TextEditingController _adressfield1 = TextEditingController();
  final TextEditingController _phonefield1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData = fetchAndCreate();
  }

  deletedata(String id) async {
    var req = await http.delete(Uri.parse('http://10.0.2.2:8000/delete/$id'));

    if (req.statusCode == 301) {
      setState(() {
        fetchData = fetchAndCreate();
        Navigator.of(context).pop();
      });
    }
  }

  addnewdata() async {
    Map<String, String> postData = {
      "name": _namefield.text,
      "address": _adressfield.text,
      "phone": _phonefield.text
    };
    String jsonString = jsonEncode(postData);
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8000/get/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );
    if (response.statusCode == 201) {
      setState(() {
        fetchData = fetchAndCreate();
        _namefield.text = "";
        _adressfield.text = "";
        _phonefield.text = "";
        Navigator.of(context).pop();
      });
    }
  }

  postupdatdata(String id) async {
    Map<String, String> postData = {
      "name": _namefield1.text,
      "address": _adressfield.text,
      "phone": _phonefield1.text
    };
    String jsonString = jsonEncode(postData);
    var response = await http.put(
      Uri.parse('http://10.0.2.2:8000/get/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );
    if (response.statusCode == 200) {
      print('done post');
      setState(() {
        fetchData = fetchAndCreate();
        Navigator.of(context).pop();
      });
      // setState(() {

      // });
    }
  }

  editdata(String id) async {
    var response = await http.get(Uri.parse('http://10.0.2.2:8000/get/$id'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      _namefield1.text = data['name'].toString();
      _phonefield1.text = data['phone'].toString();
      _adressfield1.text = data['address'].toString();
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Update Student Record'),
                content: SingleChildScrollView(
                  child: Column(children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 3),
                        child: TextField(
                          controller: _namefield1,
                          decoration: const InputDecoration(
                              hintText: 'Enter student name',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5),
                        child: TextField(
                          controller: _phonefield1,
                          decoration: const InputDecoration(
                              hintText: 'Enter student phone number',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5),
                        child: TextField(
                          controller: _adressfield1,
                          decoration: const InputDecoration(
                              hintText: 'Enter student address',
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ]),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => postupdatdata(id),
                          child: const Text('Update')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                    ],
                  )
                ],
              ));
    } else {
      const Center(child: CircularProgressIndicator());
    }

    // if (data != null) {

    // } else {
    //   const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
  }

  adddata(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add new Student Record'),
              content: SingleChildScrollView(
                child: Column(children: [
                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 3),
                      child: TextField(
                        controller: _namefield,
                        decoration: const InputDecoration(
                            hintText: 'Enter student name',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: TextField(
                        controller: _phonefield,
                        decoration: const InputDecoration(
                            hintText: 'Enter student phone number',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: TextField(
                        controller: _adressfield,
                        decoration: const InputDecoration(
                            hintText: 'Enter student address',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ]),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => addnewdata(),
                        child: const Text('Submit')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'))
                  ],
                )
              ],
            ));
  }

  deleteDialog(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Are you sure!"),
        content: const Text("That you want delete the data?"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () => deletedata(id), child: const Text('Yes')),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('No')),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Fetching data..',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: const Color.fromARGB(255, 130, 213, 129),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    fetchData = fetchAndCreate();
                  });
                },
                child: const Icon(
                  color: Colors.white,
                  Icons.refresh,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  adddata(context);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<Student>>(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Student> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 370,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: ListTile(
                                  leading: Text('${data[index].id}'),
                                  title: Text('${data[index].name}'),
                                  subtitle: Text('${data[index].phone}'),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      // udatedata('${data[index].id}');
                                      editdata('${data[index].id}');
                                    },
                                    child: const Icon(
                                      color: Colors.green,
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 11),
                              child: GestureDetector(
                                onTap: () => deleteDialog('${data[index].id}'),
                                child: const Icon(
                                  color: Colors.red,
                                  Icons.delete,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 55, right: 0, top: 1, bottom: 2),
                          child: Text(
                            '${data[index].address}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 100, 97, 97)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
