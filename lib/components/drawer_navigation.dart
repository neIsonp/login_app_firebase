import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_routes.dart';

class DrawerNavigation extends StatefulWidget {
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

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('utils')
                  .doc(user!.email)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //       'assets/images/background-image-for-navigation-drawer.png'),
                      //   fit: BoxFit.cover,
                      // ),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.green],
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: LottieBuilder.network(
                        'https://assets1.lottiefiles.com/packages/lf20_gxzsp3c5.json',
                        width: 50,
                      ),
                    ),
                    accountName: Text(
                        snapshot.data!['name'].toString().toUpperCase()[0] +
                            snapshot.data!['name'].toString().substring(1)),
                    accountEmail: Text(user!.email.toString()),
                  );
                }
              })),
          ListTile(
            leading: Image.asset(
              'assets/images/house.png',
              width: 25,
            ),
            title: const Text('Home'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.homePage,
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/brain.png', width: 25),
            title: const Text('Quiz'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.quizPage,
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/goal.png', width: 25),
            title: const Text('Goals'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.goalsPage,
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/leaderboard.png', width: 25),
            title: const Text('LeaderBoard'),
            onTap: () => _navigationTo(
              context: context,
              page: AppRoutes.leaderBoardPage,
            ),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset('assets/images/check-out.png', width: 25),
            title: const Text('Logout'),
            onTap: signOut,
          ),
        ],
      ),
    );
  }
}
