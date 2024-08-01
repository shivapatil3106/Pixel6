import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/providers/user_provider.dart';
import 'package:my_flutter_app/screens/user_list_page.dart';
import 'package:my_flutter_app/widgets/user_card.dart';
import 'package:my_flutter_app/widgets/sort_dropdown.dart';
import 'package:my_flutter_app/widgets/filter_widget.dart';

void main() {
  // Test the initial rendering of the UserListPage
  testWidgets('UserListPage initial rendering', (WidgetTester tester) async {
    // Mock UserProvider
    final userProvider = UserProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: userProvider,
        child: MaterialApp(
          home: UserListPage(),
        ),
      ),
    );

    // Verify that the loading indicator is present initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Allow some time for user data to be fetched
    await tester.pump(Duration(seconds: 2));

    // Verify that the user cards are displayed after fetching
    expect(find.byType(UserCard), findsWidgets);
  });

  // Test sorting functionality
  testWidgets('SortDropdown functionality', (WidgetTester tester) async {
    final userProvider = UserProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: userProvider,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('User List'),
              actions: [
                SortDropdown(
                  onChanged: (value) {
                    if (value != null) {
                      userProvider.sortUsers(value);
                    }
                  },
                ),
              ],
            ),
            body: UserListPage(),
          ),
        ),
      ),
    );

    // Allow some time for user data to be fetched
    await tester.pump(Duration(seconds: 2));

    // Open the sort dropdown
    await tester.tap(find.byType(SortDropdown));
    await tester.pumpAndSettle();

    // Select Sort by Name
    await tester.tap(find.text('Sort by Name').last);
    await tester.pump();

    // Verify that users are sorted by name
    final firstUserName = find.textContaining(userProvider.users.first.firstName);
    final secondUserName = find.textContaining(userProvider.users[1].firstName);
    expect(firstUserName, findsOneWidget);
    expect(secondUserName, findsOneWidget);
  });

  // Test filtering functionality
  testWidgets('FilterWidget functionality', (WidgetTester tester) async {
    final userProvider = UserProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: userProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                FilterWidget(
                  onGenderChanged: (value) {
                    userProvider.filterUsers(value ?? 'All', userProvider.filterCountry);
                  },
                  onCountryChanged: (value) {
                    userProvider.filterUsers(userProvider.filterGender, value ?? 'All');
                  },
                ),
                Expanded(child: UserListPage()),
              ],
            ),
          ),
        ),
      ),
    );

    // Allow some time for user data to be fetched
    await tester.pump(Duration(seconds: 2));

    // Open the filter dropdown and select 'Female'
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Female').last);
    await tester.pump();

    // Verify that the filter is applied
    expect(userProvider.users.every((user) => user.gender == 'female'), true);
  });

  // Test infinite scrolling
  testWidgets('Infinite scrolling fetches more users', (WidgetTester tester) async {
    final userProvider = UserProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: userProvider,
        child: MaterialApp(
          home: UserListPage(),
        ),
      ),
    );

    // Allow some time for user data to be fetched
    await tester.pump(Duration(seconds: 2));

    // Scroll to the bottom of the list to trigger more data fetching
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();

    // Verify that more users are fetched and displayed
    expect(find.byType(UserCard), findsWidgets);
  }
  );
}
