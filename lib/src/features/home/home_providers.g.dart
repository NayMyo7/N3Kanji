// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kanjiList)
final kanjiListProvider = KanjiListProvider._();

final class KanjiListProvider extends $FunctionalProvider<
        AsyncValue<List<Kanji>>, List<Kanji>, FutureOr<List<Kanji>>>
    with $FutureModifier<List<Kanji>>, $FutureProvider<List<Kanji>> {
  KanjiListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'kanjiListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$kanjiListHash();

  @$internal
  @override
  $FutureProviderElement<List<Kanji>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Kanji>> create(Ref ref) {
    return kanjiList(ref);
  }
}

String _$kanjiListHash() => r'6877a49d8c4a485b5c802f85576f602e15ec9441';

@ProviderFor(SelectedKanjiId)
final selectedKanjiIdProvider = SelectedKanjiIdProvider._();

final class SelectedKanjiIdProvider
    extends $AsyncNotifierProvider<SelectedKanjiId, int?> {
  SelectedKanjiIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedKanjiIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedKanjiIdHash();

  @$internal
  @override
  SelectedKanjiId create() => SelectedKanjiId();
}

String _$selectedKanjiIdHash() => r'805e67ceda4ff4673b3a7ca7d2b0763d11f22709';

abstract class _$SelectedKanjiId extends $AsyncNotifier<int?> {
  FutureOr<int?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int?>, int?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<int?>, int?>,
        AsyncValue<int?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(lessonWords)
final lessonWordsProvider = LessonWordsProvider._();

final class LessonWordsProvider extends $FunctionalProvider<
        AsyncValue<List<Word>>, List<Word>, FutureOr<List<Word>>>
    with $FutureModifier<List<Word>>, $FutureProvider<List<Word>> {
  LessonWordsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonWordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonWordsHash();

  @$internal
  @override
  $FutureProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Word>> create(Ref ref) {
    return lessonWords(ref);
  }
}

String _$lessonWordsHash() => r'f555bf5ef55f2355a1a2ac8aa0823e0ba7ed3942';
