import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

// Service class to handle user-related API operations
class UserService {
  // Base URL for the user API
  final String apiUrl = 'https://dummyjson.com/users';

  // Fetches a list of users from the API with pagination

  // limit is the number of records to fetch per page
  // skip is the number of records to skip used for pagination
  // Throws an exception if the API call fails
  Future<List<User>> fetchUsers(
      {
        required int limit, required int skip
      }
      ) async
  {
    // Construct the URL with query parameters for pagination
    final response = await http.get(Uri.parse('$apiUrl?limit=$limit&skip=$skip'));

    // Checking if the API response is successful
    if (response.statusCode == 200)
    {
      // Decode the JSON response and extract the list of users
      final List<dynamic> usersJson = json.decode(response.body)['users'];
      // Map the JSON data to User objects and return the list
      return usersJson.map((json) => User.fromJson(json)).toList();
    }
    else
    {
      // Throw an exception if the API response is not successful
      throw Exception('Failed to load users');
    }
  }
}
