import 'package:flutter/material.dart';
import 'package:lylblog/res/my_styles.dart';
import 'package:lylblog/res/my_theme.dart';

class BottomAboutMeWidget extends StatelessWidget {
  final bool isWideScreen;

  const BottomAboutMeWidget({Key? key, this.isWideScreen = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.95,
      duration: Duration.zero,
      child: Container(
        height: isWideScreen ? 278 : 190,
        color: MyTheme.bg_tab_bottom,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.card_giftcard, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.inbox, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.face, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
                Icon(Icons.gradient_outlined, color: MyTheme.text_block_gray_light),
                SizedBox(width: 24),
              ],
            ),
            SizedBox(height: 48),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: RichText(
                textAlign: TextAlign.center,
                strutStyle: StrutStyle(height: 1.4),
                text: TextSpan(
                  children: [
                    TextSpan(text: "© 2016, 2017 YOUR NAME  |  DESIGN: ", style: TextStyles.text(14, color: MyTheme.text_block_gray_light)),
                    TextSpan(text: "HTML5 UP  |  BUILT WITH: JEKYLL", style: TextStyles.text(14, color: MyTheme.text_block_gray_light)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
