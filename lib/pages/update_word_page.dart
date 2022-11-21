import 'package:english_vocabulary/model/word.dart';
import 'package:english_vocabulary/pages/detail_page.dart';
import 'package:english_vocabulary/service/service.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class UpdateWordPage extends StatefulWidget {
  final String? id;
  final String? name;
  final String? description;
  final String? translate;
  //final String? favorite;
  const UpdateWordPage({Key? key, 
    required this.id,
    this.name, 
    this.description, 
    this.translate, 
    //this.favorite
    })
  : super(key: key);

  @override
  State<UpdateWordPage> createState() => _UpdateWordPageState();
}

class _UpdateWordPageState extends State<UpdateWordPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController translateController = TextEditingController();

  final Services services = Services();

  //final _updateWordFormKey = GlobalKey<FormState>();

  void updateSelectedWord() {
    services.updateWord(
      context: context,
      id: widget.id.toString(),
      name: nameController.text,
      description: descriptionController.text,
      translate: translateController.text,
      onSuccess: () {
        setState(() {
          
        });
      },
    );
  }
  
  void translateToVi() async {
    final translator = GoogleTranslator();
    //var trans = translator.translate(value, from: 'en', to: 'vi').then(print);
    // translator.translate(value, from: 'en', to: 'vi').then((s) {
    //   print(s);
    // });
    String val = nameController.text.toString();
    var translation = await translator.translate(val, from: 'en', to: 'vi');
    translateController.text = translation.text;
  }
  
  @override
  void initState() {
    nameController.text = widget.name.toString();
    descriptionController.text = widget.description.toString();
    translateController.text = widget.translate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groupValue;
    String valueSelected;
    var value;
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
              onChanged: (val){
                translateToVi();
              },
              controller: nameController,
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
            
        
            // TextFormField(
            //   controller: favoriteController,
            //   decoration: InputDecoration(
            //     hintText: widget.id,
            //     border: const OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.black,
            //       ),
            //     ),
            //     enabledBorder: const OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.black,
            //       )
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            ElevatedButton(
              child: Text('Save',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: (){
                updateSelectedWord();
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage(
                //   id: widget.id,
                //   name: nameController.text,
                //   description: descriptionController.text,
                //   translate: translateController.text,
                //   //favorite: wordData.favorite               
                // )));
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