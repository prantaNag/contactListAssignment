import 'package:assignmentfive/todo_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameTEController = TextEditingController();
  TextEditingController _numberTEController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<TodoList> _contactList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
        title: Text(
          'Contact List',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameTEController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Name', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.trim() == '') {
                          return 'You must provide a name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _numberTEController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim() == '') {
                          return 'You must provide a Valed Number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        onPressed: () {
                          _addTodo();
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Card(
                        color: Colors.grey,
                        elevation: 3,
                        child: _buildData(_contactList[index], index),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Widget _buildData(TodoList todo, int i) {
    return InkWell(
      onLongPress: () async {
        return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure want to delete it ?'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel),
                ),
                IconButton(
                  onPressed: () {
                    _contactList.removeAt(i);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            );
          },
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          todo.name.toString(),
        ),
        subtitle: Text(
          todo.phone.toString(),
        ),
        trailing: Icon(
          Icons.phone,
          color: Colors.red,
        ),
      ),
    );
  }

  void dispose() {
    _nameTEController.dispose();
    _numberTEController.dispose();
    super.dispose();
  }

  void _addTodo() {
    String contactName = _nameTEController.text;
    String phoneNumber = _numberTEController.text;
    _contactList.add(TodoList(name: contactName, phone: phoneNumber));
    setState(() {});
  }
}
