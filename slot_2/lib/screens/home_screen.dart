import 'package:flutter/material.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Khai báo danh sách Task rỗng
  final List<Task> _tasks = [];

  // 2. Controller để lấy dữ liệu từ ô nhập
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 3. Hàm thêm Task mới
  void _addTask() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: text));
        _controller.clear();
      });
      FocusScope.of(context).unfocus();
    }
  }

  // YÊU CẦU NÂNG CAO 2: Hàm xóa 1 task và hiển thị SnackBar
  void _deleteTask(int index) {
    final deletedTask = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
    });

    // Ẩn SnackBar cũ nếu đang hiển thị
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Hiển thị SnackBar thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã xóa: "${deletedTask.title}"'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'HOÀN TÁC',
          onPressed: () {
            // Cho phép khôi phục lại task vừa xóa nếu lỡ tay
            setState(() {
              _tasks.insert(index, deletedTask);
            });
          },
        ),
      ),
    );
  }

  // YÊU CẦU NÂNG CAO 1: Hàm xóa tất cả các task
  void _deleteAllTasks() {
    if (_tasks.isEmpty) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: const Text("Bạn có chắc chắn muốn xóa toàn bộ danh sách?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _tasks.clear();
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã xóa tất cả các công việc!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Xóa tất cả"),
          ),
        ],
      ),
    );
  }

  // 4. Widget hiển thị từng item trong danh sách
  Widget _buildTaskItem(Task task, int index) {
    return Card(
      elevation: 2,
      // YÊU CẦU NÂNG CAO 3: Đổi màu nền của Card thành màu xanh nhạt khi hoàn thành
      color: task.isDone ? Colors.lightBlue.shade50 : Colors.white,
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (bool? value) {
            setState(() {
              task.isDone = value ?? false;
            });
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? Colors.grey : Colors.black,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _deleteTask(index), // Gọi hàm xóa kèm SnackBar
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((t) => t.isDone).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Task Manager"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        // YÊU CẦU NÂNG CAO 1: Nút "Xóa tất cả" nằm ở góc phải AppBar
        actions: [
          if (_tasks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: "Xóa tất cả",
              onPressed: _deleteAllTasks,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thống kê nhanh
            Text("Hoàn thành: $completedCount / ${_tasks.length}"),
            const SizedBox(height: 10),

            // Ô nhập liệu (TextField)
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Nhập tên công việc...",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
              onSubmitted: (_) => _addTask(),
            ),
            const SizedBox(height: 20),

            // Danh sách hiển thị (ListView)
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text("Chưa có công việc nào!"))
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskItem(_tasks[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}