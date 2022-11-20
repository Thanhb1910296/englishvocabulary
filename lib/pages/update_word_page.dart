import 'package:english_vocabulary/service/service.dart';
import 'package:flutter/material.dart';

class UpdateWordPage extends StatefulWidget {
  final String? name;
  final String? description;
  final String? translate;
  final String? favorite;
  const UpdateWordPage({Key? key, 
    required this.name, 
    this.description, 
    this.translate, 
    this.favorite})
  : super(key: key);

  @override
  State<UpdateWordPage> createState() => _UpdateWordPageState();
}

class _UpdateWordPageState extends State<UpdateWordPage> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController translateController = TextEditingController();
  final TextEditingController favoriteController = TextEditingController();
  final Services services = Services();

  final _updateWordFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 235, 156, 221),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [          
            const SizedBox(height: 20),
            TextFormField(
              controller: wordController,
              decoration: InputDecoration(
                hintText: widget.name,
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
                hintText: widget.description,
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
                hintText: widget.translate,
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
                hintText: widget.favorite,
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
            const SizedBox(height: 50),
            ElevatedButton(
              child: Text('Save',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                primary: Color.fromARGB(255, 195, 125, 241),
              ),
            ),
          ],
        ),
      ),
    );
  }
}