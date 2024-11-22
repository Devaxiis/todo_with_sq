

import 'package:flutter/material.dart';

Future<void> customBottomSheet(BuildContext context,
   {required int? id,
    required Function() update,
    required Function() addItem,
    required TextEditingController titleCon,
    required TextEditingController descCon})async{
  return showModalBottomSheet(
      context: context,
      elevation: 5,
      builder: (_) {
        return Container(
          color: Colors.amber,
          padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleCon,
                decoration: const InputDecoration(
                    hintText: "title",
                    hintStyle: TextStyle(color: Colors.white)
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descCon,
                decoration: const InputDecoration(
                    hintText: "description",
                    hintStyle: TextStyle(color: Colors.white)
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await addItem();
                    }
                    if (id != null) {
                      await update();
                    }

                    titleCon.text = "";
                    descCon.text = "";

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    id == null ? "Create new" : "Update",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 20),
            ],
          ),
        );
      });
}