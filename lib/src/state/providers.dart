import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/n3kanji_database.dart';
import '../data/repositories/n3kanji_repository.dart';
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

@riverpod
class WordStore extends _$WordStore {
  @override
  Future<List<Word>> build() async {
    return ref.watch(repositoryProvider).retrieveAllWord();
  }

  Future<void> toggleFavourite(Word word) async {
    final repo = ref.read(repositoryProvider);

    if (word.isFavourite) {
      await repo.removeFavourite(word.wordId);
    } else {
      await repo.markFavourite(word.wordId);
    }

    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (current == null) {
      state = AsyncData(await repo.retrieveAllWord());
      return;
    }

    state = AsyncData(
      current
          .map(
            (w) => w.wordId == word.wordId
                ? w.copyWith(favourite: word.isFavourite ? 0 : 1)
                : w,
          )
          .toList(growable: false),
    );
  }
}

@riverpod
List<Word>? allWordsValue(Ref ref) {
  return ref.watch(wordStoreProvider.select((v) => switch (v) {
        AsyncData(:final value) => value,
        _ => null,
      }));
}

@riverpod
List<Word> favouriteWordsValue(Ref ref) {
  final words = ref.watch(allWordsValueProvider);
  if (words == null) return const <Word>[];
  return words.where((w) => w.isFavourite).toList(growable: false);
}

@riverpod
AsyncValue<List<Word>> favouriteWords(Ref ref) {
  final all = ref.watch(wordStoreProvider);
  return all.whenData(
    (words) => words.where((w) => w.isFavourite).toList(growable: false),
  );
}

@riverpod
AsyncValue<Word?> wordById(Ref ref, int wordId) {
  final all = ref.watch(wordStoreProvider);
  return all.whenData((words) {
    for (final w in words) {
      if (w.wordId == wordId) return w;
    }
    return null;
  });
}

@riverpod
Word? wordByIdValue(Ref ref, int wordId) {
  final words = ref.watch(wordStoreProvider.select((v) => switch (v) {
        AsyncData(:final value) => value,
        _ => null,
      }));
  if (words == null) return null;
  for (final w in words) {
    if (w.wordId == wordId) return w;
  }
  return null;
}

@riverpod
AsyncValue<List<Word>> wordsByKanji(Ref ref, int kanjiId) {
  final all = ref.watch(wordStoreProvider);
  return all.whenData(
    (words) => words.where((w) => w.kanjiId == kanjiId).toList(growable: false),
  );
}

@riverpod
List<Word> wordsByKanjiValue(Ref ref, int kanjiId) {
  final words = ref.watch(allWordsValueProvider);
  if (words == null) return const <Word>[];
  return words.where((w) => w.kanjiId == kanjiId).toList(growable: false);
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
