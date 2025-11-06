import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBookDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {

  const CustomBookDetailsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white,size: 30,),
            onPressed: () => Navigator.pop(context),
          ),

            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white,size: 30,),
              onPressed: () {
                GoRouter.of(context).push('/cartScreen');
              },
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}