import 'package:flutter/material.dart';

class SortDropdown extends StatelessWidget {
  // Callback function to handle changes in the dropdown selection
  final Function(String?) onChanged;

  // Constructor to initialize the SortDropdown widget
  const SortDropdown({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return DropdownButton<String>
      (
      // Define the items in the dropdown menu
      items: const
      [
        // Option to sort by ID
        DropdownMenuItem(value: 'ID', child: Text('Sort by ID')),
        // Option to sort by Name
        DropdownMenuItem(value: 'Name', child: Text('Sort by Name')),
        // Option to sort by Age
        DropdownMenuItem(value: 'Age', child: Text('Sort by Age')),
      ],
      // Callback to be triggered when an item is selected
      onChanged: onChanged,
      // Icon to show next to the dropdown button
      icon: const Icon(Icons.sort),
    );
  }
}
