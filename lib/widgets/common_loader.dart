
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CommonLoader extends StatelessWidget {
  final Widget body;
  final bool isLoading;
  const CommonLoader({super.key, required this.body, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          body,
          isLoading ?  Opacity(
              opacity: 0.0,
              child: ModalBarrier(dismissible: false, color: ColorsConfig.lightGreyColor))
              : const SizedBox(),

          isLoading ? Center(
            child:
              //Image.asset("assets/images/loading.gif")
            CircularProgressIndicator(
              color: Colors.deepPurple,
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(ColorsConfig.darkBlue, ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}



class CommonLoaderShadow extends StatelessWidget {
  final Widget body;
  final bool isLoading;
  const CommonLoaderShadow({super.key, required this.body, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          body,
          isLoading ?  Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: ColorsConfig.lightGreyColor))
              : const SizedBox(),

          isLoading ? Center(
            child:
            //Image.asset("assets/images/loading.gif")
            CircularProgressIndicator(
              color: Colors.deepPurple,
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(ColorsConfig.darkBlue, ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
