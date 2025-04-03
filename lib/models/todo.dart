class Todo {
  static int _idCounter =
      0; // It's better to keep this private, as it's meant to be internal.

  // Static method to generate unique IDs for each Todo
  static String generateId() {
    return '${_idCounter++}'; // Increment the counter and return the ID as a string.
  }

  // Constructor with named parameters
  Todo({required this.name, this.colorCode = '#000000'}) : _id = generateId();

  // Private field for the ID
  final String _id;

  // Public properties for name and colorCode
  String name;
  String colorCode;

  // Getter for the private _id (since it's private, we need a getter if we want to access it)
  String get id => _id;
}
