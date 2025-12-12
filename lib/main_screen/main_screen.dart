import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/main_screen/boxes_file.dart';
import 'package:hive_project/notes_model/notes_model.dart';
import 'package:provider/provider.dart';

import '../functions/deletefun.dart';
import '../functions/showdialogue_fun.dart';
import '../functions/updatefun.dart';
import '../provider/provider_class.dart';

class MyAppHive extends StatefulWidget {
  const MyAppHive({super.key});

  @override
  State<MyAppHive> createState() => _MyAppHiveState();
}

class _MyAppHiveState extends State<MyAppHive> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final originalController = TextEditingController();
  String searchText = ""; // 👈 store current search text

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.dark_mode // 🌙 Dark mode icon
                  : Icons.light_mode, // ☀️ Light mode icon
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);

            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMyDialogue(context);
        },
        child: Icon(Icons.add, size: 26),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: originalController,
              decoration: InputDecoration(
                hintText: "Search Here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                  color:
                  themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),

          // 🧩 Hive Data Builder
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<NotesModel>();

                // Agar box hi empty hai
                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Is Here",
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  );
                }

                // 🔍 Filtered data logic
                var filteredData = searchText.isEmpty
                    ? data
                    : data.where((note) {
                  final title = note.title.toLowerCase();
                  final desc = note.description.toLowerCase();
                  return title.contains(searchText) ||
                      desc.contains(searchText);
                }).toList();

                // Agar search hua aur match nahi mila
                if (filteredData.isEmpty && searchText.isNotEmpty) {
                  return Center(
                    child: Text(
                      "No matching result found 😕",
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  );
                }

                // ✅ Show filtered ya all data
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final note = filteredData[index]; // 👈 important fix

                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .12,
                      height: MediaQuery.of(context).size.height * .14,
                      child: Card(
                        color: Theme.of(context).cardColor,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        note.title.toString(),
                                        style: TextStyle(fontSize: 22),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        delete(note);
                                      },
                                      child: Icon(Icons.delete),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          updateMyDialogue(
                                            context,
                                            note,
                                            note.title.toString(),
                                            note.description.toString(),
                                          );
                                        });
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  note.description.toString(),
                                  style: const TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
