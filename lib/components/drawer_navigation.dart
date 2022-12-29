import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_routes.dart';

class DrawerNavigation extends StatefulWidget {
  final User? user;
  const DrawerNavigation({super.key, required this.user});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  void _navigationTo({required BuildContext context, required String page}) {
    Navigator.of(context).pushNamed(page);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed(AppRoutes.mainPage);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background-image-for-navigation-drawer.png'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: LottieBuilder.network(
                'https://assets1.lottiefiles.com/packages/lf20_gxzsp3c5.json',
                width: 50,
              ),
            ),
            accountName: const Text('Nelson'),
            accountEmail: Text(widget.user!.email.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.homePage,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: const Text('Quiz'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.quizPage,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Goals'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.goalsPage,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text('LeaderBoard'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.leaderBoardPage,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: signOut,
          ),
        ],
      ),
    );
  }
}
