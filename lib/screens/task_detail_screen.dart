import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  // 🎨 MATERIAL 3 COLORS
  static const Color primary = Color(0xFF2563EB);
  static const Color success = Color(0xFF16A34A);
  static const Color danger = Color(0xFFDC2626);

  String formatDate(DateTime date) {
    return DateFormat('EEE, MMM d • yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final completed = task.isCompleted;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      // ✅ MATERIAL 3 APPBAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,

        title: const Text(
          "Task Details",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),

        actions: [

          IconButton(
            onPressed: () {
              onEdit();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.edit_outlined),
            color: primary,
          ),

          IconButton(
            onPressed: () => _showDeleteDialog(context),
            icon: const Icon(Icons.delete_outline_rounded),
            color: danger,
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            // ✅ MAIN CARD
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,

              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // STATUS HEADER
                    Row(
                      children: [

                        CircleAvatar(
                          radius: 32,
                          backgroundColor: completed
                              ? success.withOpacity(.12)
                              : primary.withOpacity(.12),

                          child: Icon(
                            completed
                                ? Icons.check_circle_rounded
                                : Icons.pending_actions_rounded,
                            size: 32,
                            color: completed
                                ? success
                                : primary,
                          ),
                        ),

                        const SizedBox(width: 18),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: completed
                                      ? success.withOpacity(.12)
                                      : primary.withOpacity(.12),
                                  borderRadius:
                                      BorderRadius.circular(100),
                                ),

                                child: Text(
                                  completed
                                      ? "Completed"
                                      : "Pending",
                                  style: TextStyle(
                                    color: completed
                                        ? success
                                        : primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 28,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                  decoration: completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    divider(),

                    const SizedBox(height: 28),

                    // DESCRIPTION
                    sectionTitle("Description"),

                    const SizedBox(height: 12),

                    Text(
                      task.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // INFO CARDS
                    Row(
                      children: [

                        Expanded(
                          child: infoCard(
                            icon: Icons.folder_outlined,
                            label: "Category",
                            value: task.category,
                            color: primary,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: infoCard(
                            icon: Icons.flag_outlined,
                            label: "Priority",
                            value: task.priority,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    infoCard(
                      icon: Icons.calendar_today_outlined,
                      label: "Due Date",
                      value: formatDate(task.dueDate),
                      color: Colors.teal,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ✅ MATERIAL BUTTON
            SizedBox(
              width: double.infinity,
              height: 58,

              child: FilledButton.icon(
                onPressed: () {
                  onToggle();
                  Navigator.pop(context);
                },

                icon: Icon(
                  completed
                      ? Icons.refresh_rounded
                      : Icons.check_rounded,
                ),

                label: Text(
                  completed
                      ? "Mark as Pending"
                      : "Mark as Completed",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),

                style: FilledButton.styleFrom(
                  backgroundColor:
                      completed ? Colors.black87 : primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ SECTION TITLE
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  // ✅ DIVIDER
  Widget divider() {
    return Divider(
      color: Colors.grey.shade200,
      thickness: 1,
    );
  }

  // ✅ INFO CARD
  Widget infoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool fullWidth = false,
  }) {
    return Material(
      elevation: 0,
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(22),

      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ MATERIAL DELETE DIALOG
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),

        title: const Text(
          "Delete task?",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),

        content: const Text(
          "This action cannot be undone.",
        ),

        actions: [

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          FilledButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
              Navigator.pop(context);
            },

            style: FilledButton.styleFrom(
              backgroundColor: danger,
            ),

            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}