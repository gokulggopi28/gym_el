import 'package:flutter/material.dart';
import 'package:gym_el/admin_home.dart';



class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget?_){
        return BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: [
            BottomNavigationBarItem(icon:Image.asset('assets/images/home.png',height: 30 ),
                label:'Home' ),

            BottomNavigationBarItem(icon: Image.asset('assets/images/user.png',height: 30,),
                label: 'User Profile')

          ],);
      },
    );
  }
}
