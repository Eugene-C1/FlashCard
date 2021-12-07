import 'package:flashcard/main.dart';
import 'package:flutter/material.dart';

import 'sharedpreferences.dart';
import 'sql_helper.dart';
import 'flashcardpage.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(
      () {
        _journals = data;
        _isLoading = false;
      },
    );
  }

  int points = 0;
  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
    MySharedPreferences.instance
        .getIntegerValue("points")
        .then((value) => setState(() {
              points = value;
            }));
  }

  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _questionController.text = existingJournal['question'];
      _answerController.text = existingJournal['answer'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      builder: (_) => Scaffold(
        backgroundColor: Color(0xFFB36393F),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          //reverse: true,
          child: Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  //Overflow checkz                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              `
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: TextStyle(color: Colors.white),
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: 'Question',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFBA69EBE)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFBA69EBE)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFB36393F),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      style: TextStyle(color: Colors.white),
                      controller: _answerController,
                      decoration: InputDecoration(
                        hintText: 'Answer',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFBA69EBE)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFBA69EBE)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFB36393F),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _questionController.text = '';
                      _answerController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFBA69EBE)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _questionController.text, _answerController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _questionController.text, _answerController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        },
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: MyColor.discordPurple,
          ),
          home: Scaffold(
            backgroundColor: Color(0xFFB222629),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 25.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  }),
              backgroundColor: Color(0xFFB2F3136),
              title: Text(
                'Flashcard',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _journals.length,
                    itemBuilder: (context, index) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xFFB2F3136),
                      margin: EdgeInsets.all(15),
                      child: ListTile(
                        title: Text(
                          _journals[index]['question'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          _journals[index]['answer'],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () =>
                                  _showForm(_journals[index]['id']),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () =>
                                  _deleteItem(_journals[index]['id']),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Color(0xFFBA69EBE),
                  heroTag: 'Add Button',
                  child: Icon(Icons.add),
                  onPressed: () => _showForm(null),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xFFBA69EBE),
                  heroTag: 'Next Page Button',
                  child: Icon(Icons.check),
                  onPressed: () {
                    if (_journals.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, '/flashcardpage');
                    } else {
                      final snack = SnackBar(
                        content: Text('Input at least 1 item'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
