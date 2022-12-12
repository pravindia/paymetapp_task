import 'package:flutter/material.dart';

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({super.key, required this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Center(
          child: TextButton(
              onPressed: () {
                onPressed.call();
              },
              child: const Text('Error Loading! Try Again')),
        ),
      ),
    );
  }
}
