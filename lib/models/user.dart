// A class to represent a users details
class User
{
  //identifier for the user
  final int id;

  //  user's first name
  final String firstName;

  // user's last name
  final String lastName;

  // user's age
  final int age;

  //user's gender
  final String gender;

  //user's country
  final String country;

  // URL of the user's image
  final String image;

  // Constructor for the User class.
  // It initializes all the properties of the user

  User(
      {
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.country,
    required this.image,
  }
  );

  // Factory method to create a User instance from JSON data
  // This is used to parse JSON responses from an API

  factory User.fromJson(Map<String, dynamic> json)
  {
    return User
      (
      // Extract and assign the id field from JSON.
      id: json['id'],

      // Extract and assign the firstName field from JSON.
      firstName: json['firstName'],

      // Extract and assign the lastName field from JSON.
      lastName: json['lastName'],

      // Extract and assign the age field from JSON.
      age: json['age'],

      // Extract and assign the gender field from JSON.
      gender: json['gender'],

      // Extract and assign the country field from the nested 'address' object in JSON.
      country: json['address']['country'],

      // Extract and assign the image field from JSON.
      image: json['image'],

    );
  }
}
