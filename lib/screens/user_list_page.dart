import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';
import '../widgets/sort_dropdown.dart';
import '../widgets/filter_widget.dart';

class UserListPage extends StatelessWidget
{
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    // Accessing UserProvider to manage user data and state
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          // Dropdown for sorting users
          SortDropdown(
            onChanged: (value) {
              if (value != null) {
                userProvider.sortUsers(value); // Sorting users based on selected option
              }
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Check if the user has scrolled to the bottom of the list
          if (!userProvider.isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            userProvider.fetchUsers(); // Fetch more users when scrolled to the end
            return true;
          }
          return false;
        },
        child: Column(
          children: [
            // Filter widget to select gender and country
            FilterWidget(
              onGenderChanged: (value) {
                userProvider.filterUsers(value ?? 'All', userProvider.filterCountry);
                // Update filtered users based on selected gender
              },
              onCountryChanged: (value) {
                userProvider.filterUsers(userProvider.filterGender, value ?? 'All');
                // Update filtered users based on selected country
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userProvider.users.length + 1, //  for loading indicator
                itemBuilder: (context, index) {
                  // Display loading indicator or no more users message
                  if (index == userProvider.users.length) {
                    return userProvider.hasMore
                        ? const Center(child: CircularProgressIndicator()) // Loading more users
                        : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('No more users')), // End of list
                    );
                  }

                  // Display each user card
                  final user = userProvider.users[index];
                  return UserCard(user: user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
