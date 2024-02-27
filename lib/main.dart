import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TodoHome(),
  ));
}

class TodoHome extends StatefulWidget {
  const TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  TextEditingController inputController = TextEditingController();
  TextEditingController inputController2 = TextEditingController();
  
  List<String> todos = [];
  var value ='';
  var i_t_color = Colors.blue;
  var icon_color = Colors.grey;

  bool? isChecked = false;

  Widget buildTodos() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        var item = todos[index];
        var temp ;

        return Card(
          child: ListTile(
            tileColor: Colors.grey[200],
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  inputController2.text = item;
                  return AlertDialog(
                    title: Text("Edit Item"),
                    content: TextField(
                      controller: inputController2,
                      decoration: const InputDecoration(
                        hintText: "Edit item",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                     
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            temp = item;
                            todos.remove(item);
                            todos.add(temp);
                            var tile_color = Colors.red;
                            todos[index] = Text(temp,style: TextStyle(color: tile_color), ) as String;
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Completed"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          var edit =  inputController2.text;
                          setState(() {
                            if(edit.isNotEmpty) todos[index] = edit;
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                      ),

                    ],
                  );
                },
              );
            },
            title: Text(item, style: TextStyle(color: i_t_color),),
//
//             leading: TextButton(onPressed: () {
// ,
//               setState(() {
//         temp = item;
//         todos.remove(item);
//         todos.add(temp);
//         icon_color = Colors.orange;
//         },
//
//             );}, child: Text("Done", style: TextStyle(color:icon_color ))),


            trailing: IconButton(
              onPressed: () {
                setState(() {
                  todos.removeAt(index);
                });
              },
              icon: Icon(Icons.delete ,color: i_t_color,),
            ),
          ),
        );
      },
    );
  }

  /// adding new functionality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      hintText: "What do you want to do",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                       value = inputController.text;
                      if (value.isNotEmpty) {
                        todos.insert(0, value);
                      }
                      inputController.text = '';
                    });
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
          Expanded(
            child: buildTodos(),
          ),
        ],
      ),
    );
  }
}

