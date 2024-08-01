import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier
{
  List<User> _users = []; // List to store all fetched users
  List<User> _filteredUsers = []; // List to store users after applying filters
  bool _isLoading = false; // To track if data is currently being fetched
  int _page = 0; // Current page for pagination
  final int _limit = 10; // Number of users to fetch per page
  bool _hasMore = true; // Flag to check if there are more users to fetch
  String _sortBy = 'ID'; // Current sorting criteria
  String _filterGender = 'All'; // Gender filter criteria
  String _filterCountry = 'All'; // Country filter criteria

  List<User> get users => _filteredUsers; // Expose filtered users to the UI
  bool get isLoading => _isLoading; // Expose loading state to the UI
  bool get hasMore => _hasMore; // Expose if more users are available for pagination

  final UserService _userService = UserService(); // Service to handle API calls

  UserProvider()
  {
    fetchUsers(); // Fetch initial users when the provider is created
  }

  Future<void> fetchUsers() async
  {
    if (_isLoading || !_hasMore) return; // Avoid fetching if already loading or no more users

    _isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners about the state change

    try
    {
      List<User> newUsers = await _userService.fetchUsers(
        limit: _limit,
        skip: _page * _limit,
      );

      if (newUsers.isNotEmpty)
      {
        _users.addAll(newUsers); // Add new users to the list
        _page++; // Move to the next page
      } else {
        _hasMore = false; // No more users to fetch
      }

      _applyFiltering(); // Apply filtering to the updated user list
      _applySorting(); // Apply sorting to the filtered user list
    } catch (e)
    {
      print('Error fetching users: $e'); // Print any errors that occur
    } finally
    {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners about the state change
    }
  }

  void sortUsers(String sortBy)
  {
    _sortBy = sortBy; // Update sorting criteria
    _applySorting(); // Apply sorting based on the updated criteria
    notifyListeners(); // Notify listeners about the state change
  }

  void filterUsers(String gender, String country)
  {
    _filterGender = gender; // Update gender filter
    _filterCountry = country; // Update country filter
    _applyFiltering(); // Apply filtering based on the updated criteria
    notifyListeners(); // Notify listeners about the state change
  }

  void resetUsers()
  {
    _users.clear(); // Clear the list of all users
    _filteredUsers.clear(); // Clear the list of filtered users
    _page = 0; // Reset page number
    _hasMore = true; // Reset the flag to fetch more users
    fetchUsers(); // Fetch users again
  }

  void _applySorting()
  {
    // Apply sorting based on the current sorting criteria
    switch (_sortBy) {
      case 'ID':
        _filteredUsers.sort((a, b) => a.id.compareTo(b.id)); // Sort by ID
        break;
      case 'Name':
        _filteredUsers.sort((a, b) => a.firstName.compareTo(b.firstName)); // Sort by Name
        break;
      case 'Age':
        _filteredUsers.sort((a, b) => a.age.compareTo(b.age)); // Sort by Age
        break;
    }
  }

  void _applyFiltering() {
    // Apply filtering based on the current gender and country filters
    _filteredUsers = _users.where((user) {
      bool matchesGender = _filterGender == 'All' || user.gender == _filterGender;
      bool matchesCountry = _filterCountry == 'All' || user.country == _filterCountry;
      return matchesGender && matchesCountry;
    }).toList();
  }

  // Public getters for the filter criteria
  String get filterGender => _filterGender;
  String get filterCountry => _filterCountry;
}
