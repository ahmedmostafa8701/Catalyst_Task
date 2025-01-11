import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed function here
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: UsersListView(users: [
        UserModel(
          id: 70,
          name: "Ms. Vita Jacobs",
          email: "dkshlerin@example.com",
          phone: "1-570-401-1078",
          role: "owner",
          profileImage:
              "https://bio3.catalyst.com.eg/public/Catalyst_portfolio/IMG_0997%20(1).jpg",
        ),
        UserModel(
          id: 70,
          name: "Ms. Vita Jacobs",
          email: "dkshlerin@example.com",
          phone: "1-570-401-1078",
          role: "owner",
          profileImage:
          "https://bio3.catalyst.com.eg/public/Catalyst_portfolio/IMG_0997%20(1).jpg",
        ),
      ]),
    );
  }
}
