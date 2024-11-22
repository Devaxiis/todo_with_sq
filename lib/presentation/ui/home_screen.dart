import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlflite/di/injectable.dart';
import 'package:sqlflite/domain/models.dart/todo_model.dart';
import 'package:sqlflite/presentation/widget/bottom_sheet_widget.dart';
import 'package:sqlflite/utils/toast.dart';
import '../../utils/app_colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _jurnals = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _refreshJournals() async {
    final data = await repository.readTodos();
    setState(() {
    _jurnals = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    log("...J number of items: ${_jurnals.length}");

  }

  void _deleteItem(int id) async {
    await repository.deleteTodo(id);
    AppToast.customSnack(context, "Succesfully deleted.");
    _refreshJournals();
  }

  Future<void> _addItem(
      {required String title,
        required String description,
        required int isComplate}) async {
    final data = TodoModel(
        title: title,
        description: description,
        createdAt: DateTime.now().toString(),
        count: isComplate);
    repository.createTodo(data);
    _refreshJournals();
    setState(() {

    });();
  }
  Future<void> _updateItem({
    required int? id,
    required String title,
    required String description,
    required int isComplete,
  }) async {
    final data = TodoModel(
        title: title,
        description: description,
        createdAt: DateTime.now().toString(),
        count: isComplete);
    repository.updateTodo(id!, data);
    _refreshJournals();
    setState(() {

    });();
  }
  Future<void> _updateCheck({
    required int id,
    required int isComplete,
  }) async {
    repository.updateOne(id, isComplete );
    _refreshJournals();
    setState(() {

    });();
  }



  void _showForm(int? id, int iscomplate) async {
    if (id != null) {
      final existingJournal = _jurnals.firstWhere((element) => element["id"] == id);
      _titleController.text = existingJournal["title"];
      _descriptionController.text = existingJournal["description"];
    }

    customBottomSheet(context,id: id, addItem:  (){
      _addItem(
        title: _titleController.text,
        description: _descriptionController.text,
        isComplate: 0,
      );
    }, 
    update:  (){
      _updateItem(
          id: id,
          title: _titleController.text,
          description: _descriptionController.text,
          isComplete: iscomplate);
    },
      titleCon:   _titleController,descCon:  _descriptionController);
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Todo",),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _jurnals.length,
              itemBuilder: (_, index) {
                final data = _jurnals[index];
                return Card(
                  color: Colors.amber,
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80,
                    child: ListTile(
                      leading: Checkbox(
                          value: data["count"]==1?true:false,
                          onChanged: (value) {
                            int isComplate = 0;
                            if (value == true) {
                              isComplate = 1;
                            } else {
                              isComplate = 0;
                            }
                           _updateCheck(id: data["id"], isComplete: isComplate);
                            setState(() {

                            });
                          }),
                      title: Text("${data["title"]}"),
                      subtitle: Text("${data["description"]}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _showForm(data["id"], data["count"]);
                                },
                                icon: const Icon(Icons.edit,color: AppColors.primaryBlack,)),
                            IconButton(
                                onPressed: () {
                                  _deleteItem(data["id"]);
                                },
                                icon: const Icon(Icons.delete,color: AppColors.primaryBlack,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(null, 0);
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add,color: AppColors.primaryWhite,),
      ),
    );
  }
}
