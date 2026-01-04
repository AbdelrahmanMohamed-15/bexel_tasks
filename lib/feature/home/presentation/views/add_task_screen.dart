import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/Core/Widget/custom_text_form_field.dart';
import 'package:bexel/Core/Widget/main_app_button.dart';
import 'package:bexel/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../widget/type_selection_widget.dart';
import '../widget/status_selection_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedType = 'Personal';
  String _selectedStatus = 'Incomplete';
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Adding task...');
      try {
        await HomeCubit.get(context).addTask(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          type: _selectedType,
          isCompleted: _selectedStatus,
        );

        EasyLoading.dismiss();
        EasyLoading.showSuccess('Task added successfully!');
        Navigator.of(context).pop();
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError('Failed to add task');
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
        title: const Text('Add New Task'),
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

              // Add Button
              MainAppButton(
                bgColor: AppColors.primary500,
                height: 55,
                child: Text(
                  'Add Task',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.natural100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: _addTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

