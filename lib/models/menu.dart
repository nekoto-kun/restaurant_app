class Menu {
  late String name;

  Menu({
    required this.name,
  });

  Menu.fromJson(Map<String, dynamic> menu) {
    name = menu['name'];
  }
}
