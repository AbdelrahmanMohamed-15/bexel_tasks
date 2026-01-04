import 'package:bexel/Core/Data/app_database.dart';
import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/Core/Widget/custom_text_form_field.dart';
import 'package:bexel/Core/Widget/main_app_button.dart';
import 'package:bexel/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../widget/type_selection_widget.dart';
import '../widget/status_selection_widget.dart';
import '../widget/task_created_date_widget.dart';
import '../widget/delete_task_dialog.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _selectedType;
  late String _selectedStatus;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description ?? '',
    );
    _selectedType = widget.task.type ?? 'Personal';
    _selectedStatus = widget.task.isCompleted;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateTask() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Updating task...');
      try {
        final updatedTask = Task(
          id: widget.task.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          type: _selectedType,
          isCompleted: _selectedStatus,
          createdAt: widget.task.createdAt,
        );

        await HomeCubit.get(context).updateTask(updatedTask);
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Task updated successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError('Failed to update task');
      }
    }
  }

  Future<void> _deleteTask() async {
    final confirmed = await DeleteTaskDialog.show(context);

    if (confirmed == true) {
      EasyLoading.show(status: 'Deleting task...');
      try {
        await HomeCubit.get(context).deleteTask(widget.task);
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Task deleted successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError('Failed to delete task');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.natural100,
        elevation: 3,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: AppColors.darkRed),
            onPressed: _deleteTask,
            tooltip: 'Delete Task',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Field
              CustomTextFormField(
                controller: _titleController,
                hintText: 'Task Title',
                prefixIcon: Icon(Icons.title, color: AppColors.primary500),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description Field
              CustomTextFormField(
                controller: _descriptionController,
                hintText: 'Description (Optional)',
                prefixIcon: Icon(
                  Icons.description,
                  color: AppColors.primary500,
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              // Type Selection
              Text('Task Type', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              TypeSelectionWidget(
                selectedType: _selectedType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Status Selection
              Text('Task Status', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              StatusSelectionWidget(
                selectedStatus: _selectedStatus,
                onStatusSelected: (status) {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Created Date Info
              TaskCreatedDateWidget(createdAt: widget.task.createdAt),
              const SizedBox(height: 32),

              // Update Button
              MainAppButton(
                bgColor: AppColors.primary500,
                height: 55,
                child: Text(
                  'Update Task',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.natural100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: _updateTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
