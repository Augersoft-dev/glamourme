import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(containerRoundCorner),
          color: whiteColor),
      child: Center(
        child: ListTile(
          title: const TextField(
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Search'),
          ),
          trailing: SizedBox(
            width: 60,
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 2,
                  color: backgroundColor,
                  endIndent: 10,
                  indent: 10,
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/search.png',
                      width: 24,
                      height: 24,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}