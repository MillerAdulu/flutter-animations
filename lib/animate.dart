import 'package:flutter/material.dart';

class Animate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  AnimateScreenState();
  }
}

class AnimateScreenState extends State<Animate> {
  final controller = ScrollController();
  double appBarHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SafeArea(
        child: CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            expandedHeight: appBarHeight,
            floating: true,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double percent = ((constraints.maxHeight - kToolbarHeight) *
                  100 /
                  (appBarHeight - kToolbarHeight));
              return Stack(
                children: <Widget>[
                  Image.asset(
                    'images/itestify_white.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Container(
                      height: kToolbarHeight,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Flutter is Awesome',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.animateTo(-appBarHeight,
                                  duration: Duration(seconds: 4),
                                  curve: Curves.fastOutSlowIn);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            })),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(
              title: Text("Flutter / $index"),
            );
          }),
        )
      ],
    )));
  }
}
