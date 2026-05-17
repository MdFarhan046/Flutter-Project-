import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController controller = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();

  // Auth user notestream
  final _notesStream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id'])
      .eq('uuid', Supabase.instance.client.auth.currentUser!.id);

  // Add Note
  Future<void> _addNote() async {
    try {
      await supabase.from('notes').insert({'body': controller.text});
    } catch (e) {
      mySnackBar(context, e.toString());
    }
    controller.clear();
  }

  // Update Note
  Future<void> _updateNote(int noteId, String newContent) async {
    await supabase
        .from('notes') // your table name
        .update({
          'body': newContent, // column to update
        })
        .eq('id', noteId); // condition (only update where id = noteId)
    controller.clear();
  }

  // Delete Note
  Future<void> deleteNote(int noteId) async {
    await supabase
        .from('notes') // your table name
        .delete()
        .eq('id', noteId); // condition to delete
  }

  // SnackBar
  void mySnackBar(context, content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Notes"),centerTitle: true, backgroundColor: Colors.blue),
      body: StreamBuilder(
        stream: _notesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found!!"));
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(notes[index]['body']),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.text = notes[index]['body'];
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return SimpleDialog(
                                    title: Text("Update Note"),
                                    contentPadding: EdgeInsets.all(20),
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: controller,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Field can't be empty!!";
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (value) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _updateNote(
                                                notes[index]['id'],
                                                controller.text,
                                              );
                                              mySnackBar(
                                                context,
                                                "Note updated successfully",
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _updateNote(
                                              notes[index]['id'],
                                              controller.text,
                                            );
                                            mySnackBar(
                                              context,
                                              "Note updated successfully",
                                            );
                                          }
                                        },
                                        child: Text("Update"),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: Text("Are you sure?"),
                                    contentPadding: EdgeInsets.all(20),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () {
                                              deleteNote(notes[index]['id']);
                                              mySnackBar(
                                                context,
                                                "Deleted successfully",
                                              );
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) {
              return SimpleDialog(
                title: Text("Add a Note"),
                contentPadding: EdgeInsets.all(20),
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field can't be empty";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          _addNote();
                          mySnackBar(context, "Note Added");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addNote();
                        mySnackBar(context, "Note Added");
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
