import 'package:flutter/material.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card
      (
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding
        (
        padding: const EdgeInsets.all(16.0),
        child: Row
          (
          children: [
            // Display user's avatar using a CircleAvatar
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              radius: 30.0,
            ),
            const SizedBox(width: 16.0), // Space between  text
            Expanded
              (
              child: Column
                (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show user's full name in bold
                  Text('${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8.0), // Space below the name
                  // Display age of the user
                  Text('Age: ${user.age}'),
                  const SizedBox(height: 4.0), // Small space between age and gender
                  // Display gender of the user
                  Text('Gender: ${user.gender}'),
                  const SizedBox(height: 4.0), // Small space between gender and country
                  // Display country of the user
                  Text('Country: ${user.country}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
