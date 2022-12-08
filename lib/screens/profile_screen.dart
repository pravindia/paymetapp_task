import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                height: 150,
                width: 150,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                ),
                child: Image.asset('images/user.jpeg'),
              ),
              Text(
                'Pravin Kumar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
