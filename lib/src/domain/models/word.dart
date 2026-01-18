import '../../data/db/db_value_converters.dart';

class Word {
  const Word({
    required this.wordId,
    required this.kanjiId,
    required this.word,
    required this.japanese,
    required this.burmese,
    required this.english,
    required this.favourite,
  });

  final int wordId;
  final int kanjiId;
  final String word;
  final String japanese;
  final String burmese;
  final String english;
  final int favourite;

  bool get isFavourite => favourite == 1;

  Word copyWith({int? favourite}) {
    return Word(
      wordId: wordId,
      kanjiId: kanjiId,
      word: word,
      japanese: japanese,
      burmese: burmese,
      english: english,
      favourite: favourite ?? this.favourite,
    );
  }

  factory Word.fromRow(Map<String, Object?> row) {
    return Word(
      wordId: DbValueConverter.toInt(row['_id']),
      kanjiId: DbValueConverter.toInt(row['kanji']),
      word: DbValueConverter.toStringValue(row['word']),
      japanese: DbValueConverter.toStringValue(row['japanese']),
      burmese: DbValueConverter.toStringValue(row['burmese']),
      english: DbValueConverter.toStringValue(row['english']),
      favourite: DbValueConverter.toInt(row['favourite']),
    );
  }
}
