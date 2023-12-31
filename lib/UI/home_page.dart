import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/UI/add_medicine.dart';
import 'package:medicine_app/UI/theme.dart';
import 'package:medicine_app/UI/widgets/button.dart';
import 'package:medicine_app/controllers/task_controller.dart';
import 'package:medicine_app/services/notification_services.dart';
import 'package:medicine_app/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate =  DateTime.now();
  final _taskController = Get.put(TaskController());
  var notify;

  @override
  void initState(){
  super.initState();
  notify=Notify();
  notify.initializeNotification();
  notify.requestIosPermissions();
}

  @override
  Widget build(BuildContext context) {
    print("build method called");
    return Scaffold(
appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
      children: [
       _addTaskBar(),
       _addDateBar(),
        _showTasks(),
        ],
      ),
    );
  }

  _showTasks(){
    return Expanded(
        child:Obx((){
         return ListView.builder(
           itemCount: _taskController.taskList.length,
             itemBuilder: (_,context){
             print(_taskController.taskList.length);
 return Container(
   width: 100,
   height: 50,
   color:Colors.green,
 );
         });
    }),
    );
  }


  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top:20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primarycolor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:Colors.grey
            )
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:Colors.grey
            )
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:Colors.grey
            )
        ),
        onDateChange: (date){
          _selectedDate=date;


        },
      ),


    );
  }
_addTaskBar(){
    return  Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          TheButton(label: "Add Medicine", onTap:()=> Get.to(AddMedicine()))
        ],
      ),
    );

}
  _appBar(){
return AppBar(
  elevation: 0,
  backgroundColor: context.theme.backgroundColor,
leading : GestureDetector(
   onTap:(){
  ThemeService().switchTheme();
  notify.displayNotification(
    title: "Theme Changed",
    body: Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
  );

  notify.schedualedNotification();
        },
  child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined :  Icons.nightlight_round,
    size : 20 ,
  color:Get.isDarkMode ? Colors.white:Colors.black

  ),
      ),
      actions: [
    CircleAvatar(
      backgroundImage: AssetImage(
        "images/person.png"
      ),
    ),
        SizedBox(width: 20 ,),
      ],
    );
  }
}
