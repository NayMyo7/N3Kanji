import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/n3kanji_database.dart';
import '../data/repositories/n3kanji_repository.dart';
import '../domain/models/paginated_result.dart';
import '../domain/models/word.dart';

part 'providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
N3KanjiDatabase database(Ref ref) {
  final db = N3KanjiDatabase();
  ref.onDispose(db.close);
  return db;
}

@riverpod
N3KanjiRepository repository(Ref ref) {
  return N3KanjiRepository(ref.watch(databaseProvider));
}

/// Toggle favourite status for a word.
/// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).
@riverpod
Future<Word?> toggleFavourite(Ref ref, int wordId) async {
  final repo = ref.read(repositoryProvider);
  return repo.toggleFavourite(wordId);
}

/// Fetch a single word by ID from DB
@riverpod
Future<Word?> wordById(Ref ref, int wordId) async {
  return ref.watch(repositoryProvider).retrieveWordById(wordId);
}

/// Synchronous access to word by ID (for UI that needs immediate value)
@riverpod
Word? wordByIdValue(Ref ref, int wordId) {
  final asyncWord = ref.watch(wordByIdProvider(wordId));
  return asyncWord.when(
    data: (word) => word,
    loading: () => asyncWord.hasValue ? asyncWord.value : null,
    error: (_, __) => asyncWord.hasValue ? asyncWord.value : null,
  );
}

/// Fetch words by kanji ID from DB
@riverpod
Future<List<Word>> wordsByKanji(Ref ref, int kanjiId) async {
  return ref.watch(repositoryProvider).retrieveWordsByKanji(kanjiId);
}

/// Synchronous access to words by kanji (for UI that needs immediate value)
@riverpod
List<Word> wordsByKanjiValue(Ref ref, int kanjiId) {
  final asyncWords = ref.watch(wordsByKanjiProvider(kanjiId));
  return asyncWords.when(
    data: (words) => words,
    loading: () => asyncWords.hasValue ? asyncWords.value! : const <Word>[],
    error: (_, __) => asyncWords.hasValue ? asyncWords.value! : const <Word>[],
  );
}

/// Fetch words by lesson from DB
@riverpod
Future<List<Word>> wordsByLesson(Ref ref, int lesson) async {
  return ref.watch(repositoryProvider).retrieveWordsByLesson(lesson);
}

/// Fetch paginated favourite words from DB
@riverpod
Future<PaginatedResult<Word>> favouriteWordsPaginated(
  Ref ref, {
  int page = 1,
  int pageSize = 50,
}) async {
  return ref.watch(repositoryProvider).retrieveFavouriteWordsPaginated(
        pagination: PaginationParams(page: page, pageSize: pageSize),
      );
}

/// Fetch paginated words with filters from DB
@riverpod
Future<PaginatedResult<Word>> wordsPaginated(
  Ref ref, {
  int page = 1,
  int pageSize = 50,
  WordSearchFilters filters = const WordSearchFilters(),
}) async {
  return ref.watch(repositoryProvider).retrieveWordsPaginated(
        pagination: PaginationParams(page: page, pageSize: pageSize),
        filters: filters,
      );
}

class LessonSelectionData {
  const LessonSelectionData({
    required this.lesson,
    required this.position,
  });

  final int lesson;
  final int position;

  LessonSelectionData copyWith({int? lesson, int? position}) {
    return LessonSelectionData(
      lesson: lesson ?? this.lesson,
      position: position ?? this.position,
    );
  }
}

@riverpod
class LessonSelection extends _$LessonSelection {
  static const _kLesson = 'LESSON';
  static const _kPosition = 'POSITION';

  @override
  Future<LessonSelectionData> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return LessonSelectionData(
      lesson: prefs.getInt(_kLesson) ?? 1,
      position: prefs.getInt(_kPosition) ?? 0,
    );
  }

  Future<void> setLesson(int lesson) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    await prefs.setInt(_kLesson, lesson);
    await prefs.setInt(_kPosition, 0);
    state = AsyncData(LessonSelectionData(lesson: lesson, position: 0));
  }

  Future<void> setPosition(int position) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final current =
        state.value ?? const LessonSelectionData(lesson: 1, position: 0);
    await prefs.setInt(_kPosition, position);
    state = AsyncData(current.copyWith(position: position));
  }
}
