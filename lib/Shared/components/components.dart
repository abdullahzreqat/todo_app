import 'package:flutter/material.dart';
import 'package:todo_app/Shared/components/constants.dart';


var taskController= TextEditingController();



Widget defaultFloatingButton({
  required VoidCallback onpressed,
  bool isSmall = false,
  btnColor = defaultColor,
  double shadow = 5,
  btnChild = const Icon(
    Icons.add,
    size: 30,
  ),
}) {
  return FloatingActionButton(
    onPressed: onpressed,
    mini: isSmall,
    backgroundColor: btnColor,
    elevation: shadow,
    foregroundColor: Colors.black,
    child: btnChild,
  );
}

Widget defaultTextField({suffixPress}) {
  return TextFormField(

    validator: (value){
      if(value!.isEmpty) {
        return "Task title is empty";
      }
      return null;
    },
    controller: taskController,
    autofocus: true,
    style: TextStyle(
        color: Colors.white, fontSize: 18, decoration: TextDecoration.none),
    keyboardType: TextInputType.text,
    cursorColor: Colors.grey[800],
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: IconButton(
          splashRadius: 10,
          icon: Icon(
            Icons.arrow_circle_up,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: suffixPress,
        ),
        prefixIcon: Icon(
          Icons.circle_outlined,
          color: Colors.grey[850],
        ),
        hintText: "Add a task",
        hintStyle: TextStyle(
          color: Colors.grey[800],
        )),
  );
}

