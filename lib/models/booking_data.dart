class BookingData {
  final String selectedCategory;
  final DateTime selectedDate;
  final DateTime selectedTime;
  final String weight;
  final String description;

  BookingData({
    required this.selectedCategory,
    required this.selectedDate,
    required this.selectedTime,
    required this.weight,
    required this.description,
  });

  factory BookingData.fromString(String bookingString) {
    final List<String> data = bookingString.split(',');
    final String selectedCategory = data[0];
    final DateTime selectedDate = DateTime.parse(data[1]);
    final DateTime selectedTime = _timeFromString(data[2]);
    final String weight = data[3];
    final String description = data[4];

    return BookingData(
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      weight: weight,
      description: description,
    );
  }

  String toString() {
    return '$selectedCategory,${selectedDate.toString()},${_timeToString(selectedTime)},$weight,$description';
  }

  static DateTime _timeFromString(String timeString) {
    final List<String> timeParts = timeString.split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    return DateTime(0, 1, 1, hour, minute);
  }

  static String _timeToString(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
