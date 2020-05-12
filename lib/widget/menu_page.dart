import 'package:barber_homepro/login.dart';
import 'package:flutter/material.dart';
import 'package:barber_homepro/widget/circular_image.dart';
import 'package:barber_homepro/widget/zoom_scaffold.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://scontent.fjnb9-1.fna.fbcdn.net/v/t1.0-9/p960x960/81224686_2396493097128046_2144080844195627008_o.jpg?_nc_cat=104&_nc_eui2=AeH7Db7eztW0kGSo-uJ5eNTwzMvfO9oUY71YGHk09XgSoMJYZzK2DUdPNCyZn18Bzy-IJn1nAb2pE4bhYD7rXwfXsc1snZrRN9pOlrpCgHhrJA&_nc_ohc=XaKAelOeeyIAX-JKvtn&_nc_ht=scontent.fjnb9-1.fna&_nc_tp=1002&oh=125286d1f9e2bdf6385ef00666ab874d&oe=5E96AB1A";

  final List<MenuItem> options = [
    MenuItem(Icons.account_circle, 'My Account'),
    MenuItem(Icons.favorite, 'My Favourites'),
    MenuItem(Icons.format_list_bulleted, 'New Listings'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Color(0xff454dff),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircularImage(
                    NetworkImage(imageUrl),
                  ),
                ),
                Text(
                  'Joshua Mphiwe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Column(
              children: options.map((item) {
                return ListTile(
                  onTap: () {},
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Settings',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.contacts,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Contact Us',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginClass()),
                );
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Sign Out',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}