import 'package:flutter/material.dart';

import '../../utils/color_resource.dart';

class TopGreetingWidget extends StatefulWidget {
  const TopGreetingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TopGreetingWidget> createState() => _TopGreetingWidgetState();
}

class _TopGreetingWidgetState extends State<TopGreetingWidget> {
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    greetingMessage();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Hey User,",
              style: TextStyle(
                  color: ColorsRes.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              greetingMessage(),
              style: const TextStyle(
                  color: ColorsRes.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 25,
          child: Icon(
            Icons.person,
            size: 30,
          ),
        )
      ],
    );
  }
}
