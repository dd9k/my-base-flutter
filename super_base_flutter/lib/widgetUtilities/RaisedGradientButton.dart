import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:super_base_flutter/constants/AppColors.dart';

class RaisedGradientButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final double height;
  final bool isLoading;
  final bool styleEmpty;
  final double btnTextSize;
  final RoundedLoadingButtonController btnController;

  final disable;

  RaisedGradientButton(
      {this.btnText,
      this.btnTextSize,
      @required this.onPressed,
      this.height,
      @required this.disable,
      this.isLoading,
      this.styleEmpty,
      this.btnController});

  @override
  Widget build(BuildContext context) {
    var isLoadingButton = isLoading ?? false;
    if (isLoadingButton) {
      return AbsorbPointer(
        absorbing: disable,
        child: RoundedLoadingButton(
          height: this.height ?? 35,
          onPressed: onPressed,
          controller: btnController,
          child: buildContent(context),
        ),
      );
    }
    return AbsorbPointer(
      absorbing: disable,
      child: ButtonTheme(
        height: this.height ?? 35,
        child: RaisedButton(
          onPressed: onPressed,
          color: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: buildContent(context),
        ),
      ),
    );
  }

  Ink buildContent(BuildContext context) {
    if (styleEmpty != null && styleEmpty) {
      return buildEmpty(context);
    }
    return buildFull(context);
  }

  Ink buildFull(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          gradient: disable ? AppColor.linearGradientDisabled : AppColor.linearGradient,
          borderRadius: BorderRadius.circular(4)),
      child: Container(
        constraints: BoxConstraints(minHeight: this.height ?? 35),
        alignment: Alignment.center,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Ink buildEmpty(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: Container(
        constraints: BoxConstraints(minHeight: this.height ?? 35),
        alignment: Alignment.center,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
