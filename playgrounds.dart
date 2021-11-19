import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  final result = await task2();
  task3(result);
}

void task1() {
  String result = 'Task 1 result';
  print('Task 1 completed');
}

Future<String> task2() async {
  var result = "";

  Duration duration = Duration(seconds: 5);
  await Future.delayed(duration, () {
    result = 'Task 2 result';
    print('Task 2 completed');
  });

  return result;
}

void task3(String resultsTask2) {
  String result = 'Task 3 result';
  print('Task 3 completed; Results of 2nd task: $resultsTask2');
}