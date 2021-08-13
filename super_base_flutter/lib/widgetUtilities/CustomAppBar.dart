import 'package:flutter/material.dart';
import 'package:super_base_flutter/constants/Styles.dart';
import 'package:super_base_flutter/screens/AppBarComponent.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/services/ServiceLocator.dart';
import 'package:super_base_flutter/widgetUtilities/IconContainer.dart';

/// Khoadd
/// 07/08/2021
///
class CustomAppBar extends PreferredSize {
  final double height;
  final AppBarComponent component;
  final bool isHome;
  final Color color;

  /// buildLeftComponent(context) == null && !isHome will auto have back button
  CustomAppBar({@required this.component, this.isHome = false, this.height = 50, this.color = Colors.white});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: Container(
        color: color,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (component.buildLeftComponent(context) != null) component.buildLeftComponent(context),
                if (component.buildLeftComponent(context) == null && !isHome)
                  IconContainer(
                    icon: Icons.keyboard_backspace,
                    backgroundColor: color,
                    onTap: () => locator<NavigationService>().navigatePop(context),
                  ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                if (component.buildRightComponent(context) != null) component.buildRightComponent(context)
              ],
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  component.getTitle(context).toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Styles.formFieldText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
