import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/category.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/service/category_service.dart';
import 'package:todo/service/todo_service.dart';
import 'package:todo/src/app.dart';
import 'package:intl/intl.dart';
class ToDoScreen extends StatefulWidget{
  @override
  _ToDoScreenState createState() =>_ToDoScreenState();
}
class _ToDoScreenState extends State<ToDoScreen>{
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();

  var _selectedValue;

  var _categories =  <DropdownMenuItem<String>>[];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    super.initState();
    _loadCategory();
  }

_loadCategory() async {
  var _categoryService = CategoryService();
  var categories = await _categoryService.readCategories();
  categories.forEach((category){
    setState(() {
      _categories.add(DropdownMenuItem(
        child: Text(category['name']),
      value: category['name'],
      ));
    });
  });
}
DateTime _dateTime = DateTime.now();
  _selectedToDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
    if(_pickedDate != null){
      setState(() {
        _dateTime = _pickedDate;
        todoDateController.text = DateFormat('yyy-MM-dd').format(_pickedDate);
      });
    }
  }
  _showScuccessSnackBar(message){
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState?.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write Todo Title'
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Descriptiom',
                  hintText: 'Write your description here',

              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Set your Date',
                  prefixIcon: InkWell(
                  onTap: (){
                    _selectedToDate(context);
                  },
              child: Icon(Icons.calendar_today),
            )
              ),
            ),
            DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
                hint: Text("Category"),
                onChanged:(value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                onPressed: () async {
                  var todoObject = Todo();

                  todoObject.title = todoTitleController.text;
                  todoObject.description = todoDescriptionController.text;
                  todoObject.isFinished = 0;
                  todoObject.category= _selectedValue.toString();
                  todoObject.todoDate = todoDateController.text;

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);
                    if(result > 0){
                      _showScuccessSnackBar(Text('to do created'));
                      print(result);
                    }

                },
            color: Colors.blue,
                child: Text('Save', style: TextStyle(color:Colors.white),
                ),
            ),
          ],
        ),
      ),
    );
  }

}