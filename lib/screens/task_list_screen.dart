import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onAddTask;
  final Function(String) onDeleteTask;
  final Function(Task) onToggleTask;
  final VoidCallback onClearAll;

  const TaskListScreen({
    super.key,
    required this.tasks,
    required this.onAddTask,
    required this.onDeleteTask,
    required this.onToggleTask,
    required this.onClearAll,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  String _filter = "All";

  final TextEditingController _searchController =
      TextEditingController();

  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _descController =
      TextEditingController();

  String _search = "";

  final DateTime _dueDate =
      DateTime.now().add(const Duration(days: 1));

  String _category = "General";
  String _priority = "Medium";

  // 🎨 MATERIAL COLORS
  static const Color primary = Color(0xFF2563EB);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);

  List<Task> get filteredTasks {
    List<Task> tasks = List.from(widget.tasks);

    // FILTER
    if (_filter == "Pending") {
      tasks =
          tasks.where((t) => !t.isCompleted).toList();
    }

    if (_filter == "Completed") {
      tasks =
          tasks.where((t) => t.isCompleted).toList();
    }

    // SEARCH
    if (_search.isNotEmpty) {
      tasks = tasks.where((t) {
        return t.title
            .toLowerCase()
            .contains(_search.toLowerCase());
      }).toList();
    }

    tasks.sort((a, b) =>
        a.dueDate.compareTo(b.dueDate));

    return tasks;
  }

  @override
  Widget build(BuildContext context) {

    final total = widget.tasks.length;

    final completed = widget.tasks
        .where((t) => t.isCompleted)
        .length;

    final pending = total - completed;

    final progress =
        total == 0 ? 0.0 : completed / total;

    return Scaffold(

      backgroundColor: const Color(0xFFF5F7FB),

      // ✅ MATERIAL APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,

        title: const Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),

        actions: [

          IconButton(
            onPressed: widget.onClearAll,
            icon: const Icon(Icons.delete_sweep_outlined),
            color: danger,
          ),

          const SizedBox(width: 6),
        ],
      ),

      // ✅ FLOATING BUTTON
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        backgroundColor: primary,
        foregroundColor: Colors.white,

        icon: const Icon(Icons.add),

        label: const Text(
          "New Task",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          // ✅ SEARCH
          TextField(
            controller: _searchController,

            onChanged: (v) {
              setState(() {
                _search = v;
              });
            },

            decoration: InputDecoration(
              hintText: "Search task...",

              prefixIcon: const Icon(Icons.search),

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ✅ STATS CARD
          Material(
            color: Colors.white,
            elevation: 1,

            borderRadius:
                BorderRadius.circular(28),

            child: Padding(
              padding: const EdgeInsets.all(22),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [

                      statItem(
                        "$total",
                        "Total",
                        Colors.black87,
                      ),

                      statItem(
                        "$completed",
                        "Done",
                        success,
                      ),

                      statItem(
                        "$pending",
                        "Pending",
                        warning,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(100),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,

                      backgroundColor:
                          Colors.grey.shade200,

                      color: primary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${(progress * 100).toInt()}% completed",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ✅ FILTERS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              children: [

                filterChip("All"),

                filterChip("Pending"),

                filterChip("Completed"),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ✅ TASK LIST
          if (filteredTasks.isEmpty)
            emptyState()
          else
            ...filteredTasks.map(taskTile),
        ],
      ),
    );
  }

  // ✅ FILTER CHIP
  Widget filterChip(String label) {

    final selected = _filter == label;

    return Padding(
      padding: const EdgeInsets.only(right: 10),

      child: ChoiceChip(
        label: Text(label),

        selected: selected,

        onSelected: (_) {
          setState(() {
            _filter = label;
          });
        },

        selectedColor:
            primary.withOpacity(.15),

        labelStyle: TextStyle(
          color:
              selected ? primary : Colors.black87,

          fontWeight:
              selected
                  ? FontWeight.w700
                  : FontWeight.w500,
        ),

        backgroundColor: Colors.white,
      ),
    );
  }

  // ✅ TASK TILE
  Widget taskTile(Task task) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      child: Material(
        color: Colors.white,
        elevation: 1,

        borderRadius:
            BorderRadius.circular(24),

        child: ListTile(

          contentPadding:
              const EdgeInsets.all(18),

          onTap: () =>
              widget.onToggleTask(task),

          leading: Checkbox(
            value: task.isCompleted,

            activeColor: success,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(6),
            ),

            onChanged: (_) =>
                widget.onToggleTask(task),
          ),

          title: Text(
            task.title,

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,

              decoration:
                  task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
            ),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  task.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  children: [

                    chip(
                      task.category,
                      primary,
                    ),

                    chip(
                      task.priority,
                      warning,
                    ),
                  ],
                ),
              ],
            ),
          ),

          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),

            color: danger,

            onPressed: () =>
                widget.onDeleteTask(task.id),
          ),
        ),
      ),
    );
  }

  // ✅ SMALL CHIP
  Widget chip(String text, Color color) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(.12),

        borderRadius:
            BorderRadius.circular(100),
      ),

      child: Text(
        text,

        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // ✅ STATS
  Widget statItem(
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [

        Text(
          value,

          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,

          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ✅ EMPTY STATE
  Widget emptyState() {

    return Padding(
      padding: const EdgeInsets.only(top: 80),

      child: Column(
        children: [

          Icon(
            Icons.task_alt_rounded,
            size: 90,
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 18),

          Text(
            "No tasks found",

            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Create your first task",

            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ CREATE TASK DIALOG
  Future<void> _showCreateDialog() async {

    _titleController.clear();
    _descController.clear();

    await showDialog(
      context: context,

      builder: (_) {

        return AlertDialog(

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(28),
          ),

          title: const Text(
            "Create Task",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                TextField(
                  controller: _titleController,

                  decoration:
                      const InputDecoration(
                    labelText: "Title",
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: _descController,

                  maxLines: 3,

                  decoration:
                      const InputDecoration(
                    labelText: "Description",
                  ),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: _category,

                  decoration:
                      const InputDecoration(
                    labelText: "Category",
                  ),

                  items: [
                    "General",
                    "Work",
                    "Personal",
                  ]
                      .map((e) =>
                          DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),

                  onChanged: (v) {
                    _category = v!;
                  },
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: _priority,

                  decoration:
                      const InputDecoration(
                    labelText: "Priority",
                  ),

                  items: [
                    "Low",
                    "Medium",
                    "High",
                  ]
                      .map((e) =>
                          DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),

                  onChanged: (v) {
                    _priority = v!;
                  },
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text("Cancel"),
            ),

            FilledButton(
              onPressed: () {

                if (_titleController.text
                    .trim()
                    .isEmpty) {
                  return;
                }

                final task = Task(
                  id: DateTime.now()
                      .millisecondsSinceEpoch
                      .toString(),

                  title:
                      _titleController.text,

                  description:
                      _descController.text,

                  category: _category,

                  priority: _priority,

                  dueDate: _dueDate,
                );

                widget.onAddTask(task);

                Navigator.pop(context);
              },

              style: FilledButton.styleFrom(
                backgroundColor: primary,
              ),

              child: const Text("Create"),
            ),
          ],
        );
      },
    );
