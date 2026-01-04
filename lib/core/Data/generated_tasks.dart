import 'package:bexel/Core/Data/app_database.dart';

List<Task> generateTasks() {
  final List<Task> tasks = [
    Task(
      id: 1,
      title: "Task 1 - Buy groceries",
      description: "Milk, Bread, Cheese, Fruits",
      type: "Personal",
      isCompleted: "Incomplete",
      createdAt: DateTime.parse("2025-11-01T10:00:00Z"),
    ),
    Task(
      id: 2,
      title: "Task 2 - Finish project report",
      description: "Complete the final draft and send to manager",
      type: "Work",
      isCompleted: "Incomplete",
      createdAt: DateTime.parse("2025-10-28T14:30:00Z"),
    ),
    Task(
      id: 3,
      title: "Task 3 - Morning workout",
      description: "30 minutes running and stretching",
      type: "Personal",
      isCompleted: "Complete",
      createdAt: DateTime.parse("2025-11-05T06:15:00Z"),
    ),
    Task(
      id: 4,
      title: "Task 4 - Team meeting",
      description: "Discuss milestones and deadlines",
      type: "Work",
      isCompleted: "Complete",
      createdAt: DateTime.parse("2025-11-03T09:00:00Z"),
    ),
    Task(
      id: 5,
      title: "Task 5 - Call plumber",
      description: "Fix leaking faucet in kitchen",
      type: "Personal",
      isCompleted: "Incomplete",
      createdAt: DateTime.parse("2025-11-04T11:00:00Z"),
    ),
  ];

  final baseDate = DateTime.parse("2025-11-01T00:00:00Z");

  for (int i = 6; i <= 10000; i++) {
    tasks.add(
      Task(
        id: i,
        title: "Task $i - Auto generated task",
        description: "This is dynamically generated task number $i",
        type: i.isEven ? "Work" : "Personal",
        isCompleted: i % 3 == 0 ? "Complete" : "Incomplete",
        createdAt: baseDate.add(Duration(minutes: i * 10)),
      ),
    );
  }

  return tasks;
}
