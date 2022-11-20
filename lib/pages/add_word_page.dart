import 'dart:io';
import 'package:english_vocabulary/service/service.dart';
import 'package:flutter/material.dart';


class AddWordPage extends StatefulWidget {
  // static const String routeName = '/add-word';
  const AddWordPage({Key? key}) : super(key: key);

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController translateController = TextEditingController();
  final TextEditingController favoriteController = TextEditingController();
  final Services services = Services();

  final _addWordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Call dispose when the object is permanently deleted
    super.dispose();
    wordController.dispose();
    descriptionController.dispose();
    translateController.dispose();
    favoriteController.dispose();
  }
  
  void addWord() {
    if (_addWordFormKey.currentState!.validate()) {
      services.addWord(
        context: context,
        name: wordController.text,
        description: descriptionController.text,
        translate: translateController.text,
        favorite: favoriteController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 194, 59, 199),
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: GlobalVariables.appBarGradient,
          //   ),
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addWordFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                TextFormField(
                  controller: wordController,
                  decoration: InputDecoration(
                    hintText: 'Add a new word',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: translateController,
                  decoration: InputDecoration(
                    hintText: 'Translate',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: favoriteController,
                  decoration: InputDecoration(
                    hintText: 'Favorite ?',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Save',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
                    addWord();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    primary: Color.fromARGB(255, 167, 34, 207),
                  ),
                ),
              ]
            )
          )
        )
      )
    );
  }
}