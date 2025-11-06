import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/resources/assets.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AssetsImages.logo,
            cacheWidth: 90,
            color: Colors.white,
          ),
          IconButton(onPressed: (){
            GoRouter.of(context).push('/searchScreen');
          },
              icon: (const Icon(Icons.search,
                size: 30,
                color: Colors.white,
              )))
        ],
      ),
    );
  }
}
