

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppToast{



  static void customSnack(BuildContext context, String title){
    ScaffoldMessenger.of(context).showSnackBar(

         SnackBar(
            backgroundColor: Colors.amber,
            content:  Text(title,style: const TextStyle(color: AppColors.primaryBlack),)));
  }


}