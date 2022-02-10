import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/drawar_navigation.dart';
import 'package:todo/screens/todo_screen.dart';
import 'package:todo/service/todo_service.dart';
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  TodoService? _todoService;
  List<Todo> _todolist = <Todo>[];

  @override
  void initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async{
    _todoService = TodoService();
    _todolist = <Todo>[];

    var todos = await _todoService?.readTodos();

    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todolist.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(  // app bar to show in the top bar of the app.
       title: Text("My To Do List"),
     ),
     drawer: DrawerNavigation(),
     body: ListView.builder(
         itemCount: _todolist.length,
         itemBuilder: (context, index){
           return Padding(
             padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
             child: Card(
               elevation: 8,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(0)
               ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_todolist[index].title ?? 'No Title')
                  ],
                ),
                subtitle: Text(_todolist[index].category ?? 'No category'),
                trailing: Text(_todolist[index].todoDate ?? 'No Date'),
              ),
             ),
           );
         }),
     floatingActionButton: FloatingActionButton(
       onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoScreen())),
       child: Icon(Icons.add),
     ),
   );
  }

}