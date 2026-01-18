import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/kanji.dart';
import '../../domain/models/word.dart';
import '../../state/providers.dart';

part 'home_providers.g.dart';

@riverpod
Future<List<Kanji>> kanjiList(Ref ref) async {
  final selection = await ref.watch(lessonSelectionProvider.future);
  return ref.watch(repositoryProvider).retrieveKanji(selection.lesson);
}

@riverpod
class SelectedKanjiId extends _$SelectedKanjiId {
  static const _kPrefix = 'SELECTED_KANJI_ID_LESSON_';

  @override
  Future<int?> build() async {
    final selection = await ref.watch(lessonSelectionProvider.future);
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return prefs.getInt('$_kPrefix${selection.lesson}');
  }

  Future<void> setSelectedId(int? kanjiId) async {
    final selection = await ref.watch(lessonSelectionProvider.future);
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final key = '$_kPrefix${selection.lesson}';

    if (kanjiId == null) {
      await prefs.remove(key);
      state = const AsyncData(null);
      return;
    }

    await prefs.setInt(key, kanjiId);
    state = AsyncData(kanjiId);
  }
}

@riverpod
Future<List<Word>> lessonWords(Ref ref) async {
  // Watch lesson selection to trigger rebuild when lesson changes
  await ref.watch(lessonSelectionProvider.future);
  final kanjiList = await ref.watch(kanjiListProvider.future);
  final allWords = await ref.watch(wordStoreProvider.future);

  // Get all kanji IDs for this lesson
  final kanjiIds = kanjiList.map((k) => k.id).toSet();

  // Filter words that belong to kanji in this lesson
  return allWords
      .where((w) => kanjiIds.contains(w.kanjiId))
      .toList(growable: false);
}
