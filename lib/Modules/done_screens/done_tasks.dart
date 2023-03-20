import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/components/constants.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map> doneTasks = AppCubit.get(context).doneTasks;
        AppCubit cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Done Tasks",
                style: TextStyle(
                    color: defaultColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) => Dismissible(
                    key: Key((cubit.doneTasks[i]['id']).toString()),
                    background: Container(
                      color: Colors.red[900],
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 20.0),
                              child: Icon(
                                Icons.delete_forever,
                                size: 35,
                              ),
                            )
                          ]),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      cubit.deleteFromDatabase(
                          id: cubit.doneTasks[i]['id']);
                      cubit.doneTasks.removeAt(i);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: secondColor,
                      ),
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                cubit.updateDataFromDataBase(id: cubit.doneTasks[i]['id'],status: 'new');
                              },
                              icon: Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 27,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    doneTasks[i]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  if (cubit.doneTasks[i]['date'] !="" && cubit.doneTasks[i]['time'] !="")
                                    Row(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 11,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            doneTasks[i]['date'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.alarm,
                                            size: 11,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            doneTasks[i]['time'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    ])
                                  else if (cubit.doneTasks[i]['time'] !="")
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.alarm,
                                          size: 11,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          doneTasks[i]['time'],
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        )
                                      ],
                                    )
                                  else if (cubit.doneTasks[i]['date'] !="")
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 11,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            doneTasks[i]['date'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w200),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )

                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.changeFavIconState(id: doneTasks[i]['id'],favState: doneTasks[i]['favourite']);
                            },
                            icon: doneTasks[i]['favourite']=='yes'?Icon(
                              Icons.star,
                              color: defaultColor,

                            ):Icon(
                              Icons.star_border_outlined,
                              color: Colors.white70,
                            )
                            ,
                            splashRadius: 1,
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.updateDataFromDataBase(
                                  id: cubit.doneTasks[i]['id'],
                                  status: 'archived');
                            },
                            icon: Icon(
                              Icons.archive,
                              color: Colors.white70,
                              size: 22,
                            ),
                            splashRadius: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    height: 3,
                  ),
                  itemCount: doneTasks.length),
            ],
          ),
        );
        /*Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: secondColor,
        ),
        height: 70,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.circle_outlined,
                  color: Colors.white60,
                  size: 28,
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tasks[i]['title'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 11,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            tasks[i]['date'],
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.alarm,
                            size: 11,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            tasks[i]['time'],
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                          )
                        ],
                      )
                    ])
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
             cubit.changeFavIconState();
              },
              icon: cubit.favIconPressed
                  ? Icon(
                Icons.star,
                color: defaultColor,
              )
                  : Icon(
                Icons.star_border_outlined,
                color: Colors.white70,
              ),
              splashRadius: 1,
            )
          ],
        ),
      )*/
      },
    );
  }
}
