import '../../data/db/db_value_converters.dart';

class Kanji {
  const Kanji({
    required this.id,
    required this.lesson,
    required this.kanji,
    required this.onyomi,
    required this.konyomi,
  });

  final int id;
  final int lesson;
  final String kanji;
  final String onyomi;
  final String konyomi;

  factory Kanji.fromRow(Map<String, Object?> row) {
    return Kanji(
      id: DbValueConverter.toInt(row['_id']),
      lesson: DbValueConverter.toInt(row['lesson']),
      kanji: DbValueConverter.toStringValue(row['kanji']),
      onyomi: _convertToSeparatedLines(
          DbValueConverter.toStringValue(row['onyomi'])),
      konyomi: _convertToSeparatedLines(
          DbValueConverter.toStringValue(row['konyomi'])),
    );
  }

  static String _convertToSeparatedLines(String value) {
    if (value.isEmpty) return value;
    // Split by comma and trim whitespace, then join with newlines
    final parts = value
        .split(',')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty);
    return parts.join('\n');
  }
}
