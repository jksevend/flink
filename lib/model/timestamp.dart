abstract class Timestamp {
  DateTime createdAt;
  DateTime updatedAt;

  Timestamp()
      : createdAt = DateTime.now(),
        updatedAt = DateTime.now();
}
