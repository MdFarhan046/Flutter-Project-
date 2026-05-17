import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:md_farhan_ahmed_046_63b/widget/input_field.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController wordController = TextEditingController();

  String word = "";
  String meaning = "";
  String partOfSpeech = "";

  bool isLoading = false;

  Future<void> searchWord() async {
    String searchWord = wordController.text.trim();

    if (searchWord.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter a word")));

      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$searchWord"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        word = data[0]['word'];

        meaning = data[0]['meanings'][0]['definitions'][0]['definition'];

        partOfSpeech = data[0]['meanings'][0]['partOfSpeech'];
      });
    } else {
       setState(() {
        word = "";
        meaning = "";
        partOfSpeech = "";
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Word not found")));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictionary App"),

        backgroundColor: const Color.fromARGB(255, 94, 39, 176),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            InputField(
              controller: wordController,
              obsecureText: false,
              keyboardType: TextInputType.text,
              validator: (value) {},
              hintText: "Enter word",
              labelText: "Word",

              prefixIcon: const Icon(Icons.search),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 200,

              child: ElevatedButton(
                onPressed: searchWord,

                child: const Text("Search"),
              ),
            ),

            const SizedBox(height: 30),

            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            word,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            partOfSpeech,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Meaning:",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(meaning, style: const TextStyle(fontSize: 18)),

                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
