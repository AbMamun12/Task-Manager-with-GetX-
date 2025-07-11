import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/profile_screen.dart';
import 'package:task_manager/Ui/screens/sign_in_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key,
  this.isProfileScreenopen=false
  });


  final bool isProfileScreenopen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenopen){
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            CircleAvatar(radius: 16, backgroundColor: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdullah Al Mamun',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Abdullah.mamun8191@gmail.com',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (predicate) => false,
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
