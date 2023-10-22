extension StringCustomizations on String {
  String get extractName => substring(
        0,
        !contains(' - ') ? length : indexOf(' - '),
      );

  String get extractDescription => substring(
        !contains(' - ') ? length : indexOf(' - ') + 3,
        length,
      );
}
