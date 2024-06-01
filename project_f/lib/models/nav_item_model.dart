import 'package:project_f/models/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Home",
    rive: RiveModel(
        src: "assets/animated_icon_set.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  NavItemModel(
    title: "Search",
    rive: RiveModel(
        src: "assets/animated_icon_set.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
  ),
  NavItemModel(
    title: "Star",
    rive: RiveModel(
        src: "assets/animated_icon_set.riv",
        artboard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity"),
  ),
  NavItemModel(
    title: "Notification",
    rive: RiveModel(
        src: "assets/animated_icon_set.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
  ),
  NavItemModel(
    title: "Settings",
    rive: RiveModel(
        src: "assets/animated_icon_set.riv",
        artboard: "SETTINGS",
        stateMachineName: "SETTINGS_Interactivity"),
  ),
];
