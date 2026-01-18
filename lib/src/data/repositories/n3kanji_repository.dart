import '../../domain/models/kanji.dart';
import '../../domain/models/paginated_result.dart';
import '../../domain/models/word.dart';
import '../db/n3kanji_database.dart';

class N3KanjiRepository {
  N3KanjiRepository(this._db);

  final N3KanjiDatabase _db;

  Future<List<Kanji>> retrieveKanji(int lesson) async {
    final rows =
        await _db.rawQuery('SELECT * FROM kanji WHERE lesson=?', [lesson]);
    return rows.map(Kanji.fromRow).toList(growable: false);
  }

  Future<List<Word>> retrieveWord(int kanjiId) async {
    final rows =
        await _db.rawQuery('SELECT * FROM word WHERE kanji=?', [kanjiId]);
    return rows.map(Word.fromRow).toList(growable: false);
  }

  /// Retrieve all words - kept for backward compatibility but consider using paginated version
  Future<List<Word>> retrieveAllWord() async {
    final rows = await _db.rawQuery('SELECT * FROM word');
    return rows.map(Word.fromRow).toList(growable: false);
  }

  /// Retrieve paginated words with optional search filters
  Future<PaginatedResult<Word>> retrieveWordsPaginated({
    required PaginationParams pagination,
    WordSearchFilters filters = const WordSearchFilters(),
  }) async {
    final whereConditions = <String>[];
    final whereArgs = <Object?>[];

    // Build WHERE clause based on filters
    if (filters.favouritesOnly) {
      whereConditions.add('favourite = ?');
      whereArgs.add(1);
    }

    if (filters.lesson != null) {
      // Filter by lesson via kanji foreign key
      whereConditions.add('kanji IN (SELECT _id FROM kanji WHERE lesson = ?)');
      whereArgs.add(filters.lesson);
    }

    if (filters.query != null && filters.query!.isNotEmpty) {
      final searchQuery = '%${filters.query!.toLowerCase()}%';
      whereConditions.add(
        '(LOWER(word) LIKE ? OR LOWER(japanese) LIKE ? OR LOWER(burmese) LIKE ? OR LOWER(english) LIKE ?)',
      );
      whereArgs.addAll([searchQuery, searchQuery, searchQuery, searchQuery]);
    }

    final whereClause =
        whereConditions.isEmpty ? '' : 'WHERE ${whereConditions.join(' AND ')}';

    // Get total count
    final countResult = await _db.rawQuery(
      'SELECT COUNT(*) as count FROM word $whereClause',
      whereArgs,
    );
    final totalCount = countResult.first['count'] as int;

    // Get paginated results
    final rows = await _db.rawQuery(
      'SELECT * FROM word $whereClause ORDER BY _id LIMIT ? OFFSET ?',
      [...whereArgs, pagination.limit, pagination.offset],
    );

    final items = rows.map(Word.fromRow).toList(growable: false);

    return PaginatedResult(
      items: items,
      totalCount: totalCount,
      page: pagination.page,
      pageSize: pagination.pageSize,
    );
  }

  /// Retrieve favourite words - kept for backward compatibility
  Future<List<Word>> retrieveFavouriteWord() async {
    final rows =
        await _db.rawQuery('SELECT * FROM word WHERE favourite=?', [1]);
    return rows.map(Word.fromRow).toList(growable: false);
  }

  /// Retrieve paginated favourite words
  Future<PaginatedResult<Word>> retrieveFavouriteWordsPaginated({
    required PaginationParams pagination,
  }) async {
    return retrieveWordsPaginated(
      pagination: pagination,
      filters: const WordSearchFilters(favouritesOnly: true),
    );
  }

  /// Get total word count (useful for UI)
  Future<int> getTotalWordCount() async {
    final result = await _db.rawQuery('SELECT COUNT(*) as count FROM word');
    return result.first['count'] as int;
  }

  /// Get favourite word count
  Future<int> getFavouriteWordCount() async {
    final result = await _db.rawQuery(
      'SELECT COUNT(*) as count FROM word WHERE favourite=?',
      [1],
    );
    return result.first['count'] as int;
  }

  Future<void> markFavourite(int id) async {
    await _db.update(
      'word',
      {'favourite': 1},
      where: '_id=?',
      whereArgs: [id],
    );
  }

  Future<void> removeFavourite(int id) async {
    await _db.update(
      'word',
      {'favourite': 0},
      where: '_id=?',
      whereArgs: [id],
    );
  }
}
