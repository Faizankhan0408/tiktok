import 'package:flutter/material.dart';
import 'package:tiktok/view/widgets/glitch_effect.dart';
class customAddIcon extends StatelessWidget {
  const customAddIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlithEffect(
      child: SizedBox(
        height: 30,
        width: 45,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 38,
              decoration: BoxDecoration(
                color: Color.fromARGB(250,250,45,108),
                borderRadius: BorderRadius.circular(7)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 38,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255,32,211,234),
                  borderRadius: BorderRadius.circular(7)
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
