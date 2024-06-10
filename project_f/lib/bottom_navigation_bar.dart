import 'package:flutter/material.dart';
import 'package:project_f/Pages/favorites_page.dart';
import 'package:project_f/Pages/home_page.dart';
import 'package:project_f/Pages/notification_page.dart';
import 'package:project_f/Pages/search_page.dart';
import 'package:project_f/Pages/user_page.dart';
import 'package:project_f/models/nav_item_model.dart';
import 'package:rive/rive.dart';

const Color bottomNavBgColor = Color.fromARGB(255, 34, 40, 49);

class BottomNavWithAnimatedIcons extends StatefulWidget {
  const BottomNavWithAnimatedIcons({super.key});

  @override
  State<BottomNavWithAnimatedIcons> createState() =>
      _BottomNavWithAnimatedIcons();
}

class _BottomNavWithAnimatedIcons extends State<BottomNavWithAnimatedIcons> {
  List<SMIBool?> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const NotificationPage(),
    const UserPage(),
  ];
  int selectedNavIndex = 0;

  void animateTheIcon(int index) {
    riveIconInputs[index]?.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      riveIconInputs[index]?.value = false;
    });
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    final controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
      controllers.add(controller);

      final input = controller.findInput<bool>("active") as SMIBool?;
      if (input != null) {
        riveIconInputs.add(input);
      } else {
        riveIconInputs.add(null);
        debugPrint('Failed to find SMIBool input "active"');
      }
    } else {
      controllers.add(null);
      riveIconInputs.add(null);
      debugPrint('Failed to create StateMachineController');
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: pages[selectedNavIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              color: bottomNavBgColor,
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomNavItems.length, (index) {
                final riveIcon = bottomNavItems[index].rive;
                return GestureDetector(
                  onTap: () {
                    if (riveIconInputs[index] != null) {
                      animateTheIcon(index);
                    }
                    setState(() {
                      selectedNavIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive: selectedNavIndex == index,
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: selectedNavIndex == index ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            riveIcon.src,
                            artboard: riveIcon.artboard,
                            onInit: (artboard) {
                              riveOnInit(artboard,
                                  stateMachineName: riveIcon.stateMachineName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
