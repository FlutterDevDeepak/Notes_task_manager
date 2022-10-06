import 'package:flutter/material.dart';

import '../../models/notes.dart';
import '../../utils/color_resource.dart';

class NotesCard extends StatelessWidget {
  Notes notes;
  NotesCard({
    required this.notes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBGClr(notes.color),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notes.title,
              style: const TextStyle(
                  color: ColorsRes.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              notes.description,
              style: const TextStyle(
                  color: ColorsRes.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              notes.date,
            ),
          ],
        ),
      ),
    );
  }
}

_getBGClr(int no) {
  switch (no) {
    case 0:
      return ColorsRes.skyColor;
    case 1:
      return ColorsRes.lightOrangeColor;
    case 2:
      return ColorsRes.lightPinkColor;

    default:
      return ColorsRes.skyColor;
  }
}
