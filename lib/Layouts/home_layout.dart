// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/components/constants.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  final List<BottomNavigationBarItem> navigationBarIcons = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.list,
        ),
        label: "Tasks"),
    BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined), label: "Archive"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: navigationBarIcons,
                currentIndex: cubit.itemIndex,
                selectedIconTheme: IconThemeData(size: 25, color: defaultColor),
                unselectedIconTheme:
                    IconThemeData(size: 22, color: Colors.grey),
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.black,
                onTap: (i) {
                  cubit.changeIndex(i);
                },
              ),
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/accountImage.jpg"),
                      radius: 18,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Abdullah Zreqat",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Stavros.zreqat@gmail.com",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: defaultColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.all(14),
                child: cubit.screens[cubit.itemIndex],
              ),
            );
          }),
    );
  }
}
