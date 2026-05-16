import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/profile_screen.dart';
import 'models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,

      // ✅ MATERIAL 3 THEME
      theme: ThemeData(
        useMaterial3: true,

        colorSchemeSeed: const Color(0xFF2563EB),

        brightness: Brightness.light,

        scaffoldBackgroundColor:
            const Color(0xFFF5F7FB),

        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),

        cardTheme: CardThemeData(
          elevation: 1,
          color: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(18),

            borderSide: const BorderSide(
              color: Color(0xFF2563EB),
              width: 1.5,
            ),
          ),
        ),
      ),

      home: const MainContainer(),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() =>
      _MainContainerState();
}

class _MainContainerState
    extends State<MainContainer> {

  int _selectedIndex = 0;

  final List<Task> _tasks = [];

  // ✅ ADD OR UPDATE
  void _addOrUpdateTask(Task task) {

    setState(() {

      final index = _tasks.indexWhere(
        (t) => t.id == task.id,
      );

      if (index != -1) {
        _tasks[index] = task;
      } else {
        _tasks.add(task);
      }
    });
  }

  // ✅ DELETE TASK
  void _deleteTask(String id) {

    setState(() {
      _tasks.removeWhere(
        (t) => t.id == id,
      );
    });
  }

  // ✅ TOGGLE TASK
  void _toggleTask(Task task) {

    final updated = task.copyWith(
      isCompleted: !task.isCompleted,
    );

    _addOrUpdateTask(updated);
  }

  // ✅ CLEAR ALL
  void _clearAllTasks() {

    setState(() {
      _tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    final screens = [

      TaskListScreen(
        tasks: _tasks,

        onAddTask: _addOrUpdateTask,

        onDeleteTask: _deleteTask,

        onToggleTask: _toggleTask,

        onClearAll: _clearAllTasks,
      ),

      const ProfileScreen(),
    ];

    return Scaffold(

      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),

      // ✅ MATERIAL 3 NAVIGATION BAR
      bottomNavigationBar: NavigationBar(

        selectedIndex: _selectedIndex,

        backgroundColor: Colors.white,

        surfaceTintColor: Colors.transparent,

        elevation: 2,

        height: 72,

        labelBehavior:
            NavigationDestinationLabelBehavior
                .alwaysShow,

        onDestinationSelected: (index) {

          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(
              Icons.checklist_rtl_outlined,
            ),

            selectedIcon: Icon(
              Icons.checklist_rounded,
            ),

            label: "Tasks",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
            ),

            selectedIcon: Icon(
              Icons.person_rounded,
            ),

            label: "Profile",
          ),
        ],
      ),
    );
  }
}