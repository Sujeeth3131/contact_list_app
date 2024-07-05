import 'package:contact_list_app/contact.dart';
import 'package:flutter/material.dart';

import 'contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Contact List',style: TextStyle(color:Colors.black,fontSize: 24 ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(fillColor: Colors.grey,filled: true,
                    hintText: 'Enter your Contact Name',hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ))),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contactController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration:  InputDecoration(
                    fillColor: Colors.grey,filled: true,
                    hintText: 'Enter your Contact Number',hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ))),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts.add(Contact(name: name, contact: contact));
                          });
                        }
                        //
                      },
                      child: const Text('Save')),
                  ElevatedButton(
                      onPressed: () {
                        //
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].contact = contact;
                            selectedIndex = -1;
                          });
                        }
                        //
                      },
                      child: const Text('Update')),
                ],
              ),
              const SizedBox(height: 30),
              contacts.isEmpty
                  ? const Text(
                'No Contact yet..',
                style: TextStyle(fontSize: 22),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}