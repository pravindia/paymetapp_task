import 'package:flutter/material.dart';

import '../serializers/users.dart';

class DismissibleUserTile extends StatefulWidget {
  const DismissibleUserTile({
    super.key,
    required this.onDismissed,
    required this.user,
  });
  final Function(DismissDirection)? onDismissed;
  final Users user;

  @override
  State<DismissibleUserTile> createState() => DismissibleUserTileState();
}

class DismissibleUserTileState extends State<DismissibleUserTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: widget.onDismissed,
      key: ValueKey<int>(widget.user.id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.pink.shade100, Colors.pink.shade300, Colors.pink],
          ),
        ),
        child: ListTile(
          title: Text(widget.user.name),
        ),
      ),
    );
  }
}
