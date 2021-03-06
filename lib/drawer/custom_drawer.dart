import 'package:e_commerce_estudo/constants.dart';
import 'package:e_commerce_estudo/models/user_model.dart';
import 'package:e_commerce_estudo/screens/login/login_screen.dart';
import 'package:e_commerce_estudo/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          buildDrawerBack(),
          ListView(
            padding:
                EdgeInsets.only(left: kDefaultPadding, top: kDefaultPadding),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: kDefaultPadding / 2.5),
                padding: EdgeInsets.fromLTRB(
                    0, kDefaultPadding, kDefaultPadding, kDefaultPadding / 2.5),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                        top: 8,
                        left: 0,
                        child: Text(
                          "E-Commerce\nEstudo",
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!model.isLoggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    else
                                      model.signOut();
                                  },
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Ínicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }

  Container buildDrawerBack() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kBackgroundColor, kBackgroundColor.withAlpha(150)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}
