import 'package:flutter/material.dart';

// A widget that provides dropdowns for filtering users by gender and country

class FilterWidget extends StatelessWidget {
  // Callback function triggered when the selected gender changes

  final Function(String?) onGenderChanged;

  // Callback function triggered when the selected country changes.
  final Function(String?) onCountryChanged;

  // Creates a FilterWidget with the provided gender and country change callbacks.
  const FilterWidget(
      {
    Key? key,
    required this.onGenderChanged,
    required this.onCountryChanged,
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Dropdown for selecting gender
        DropdownButton<String>(
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All Genders')),
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onChanged: onGenderChanged, // Call the provided function when selection changes
          icon: const Icon(Icons.filter_list), // Icon for the dropdown button
        ),
        // Dropdown for selecting country
        DropdownButton<String>
          (
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All Countries')),
            DropdownMenuItem(value: 'Finland', child: Text('Finland')),
            DropdownMenuItem(value: 'India', child: Text('India')),
            DropdownMenuItem(value: 'USA', child: Text('USA')),
            DropdownMenuItem(value: 'Bangladesh', child: Text('Bangladesh')),
            // You can add more countries here as needed
          ],
          onChanged: onCountryChanged, // Call the provided function when selection changes
          icon: const Icon(Icons.public), // Icon for the dropdown button
        ),
      ],
    );
  }
}
