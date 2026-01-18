// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider extends $FunctionalProvider<
        AsyncValue<SharedPreferences>,
        SharedPreferences,
        FutureOr<SharedPreferences>>
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  SharedPreferencesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sharedPreferencesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'6c03b929f567eb6f97608f6208b95744ffee3bfd';

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider extends $FunctionalProvider<N3KanjiDatabase,
    N3KanjiDatabase, N3KanjiDatabase> with $Provider<N3KanjiDatabase> {
  DatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'databaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<N3KanjiDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  N3KanjiDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(N3KanjiDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<N3KanjiDatabase>(value),
    );
  }
}

String _$databaseHash() => r'db3f28cdb7b232efb80e62f3fd0c307b6727720a';

@ProviderFor(repository)
final repositoryProvider = RepositoryProvider._();

final class RepositoryProvider extends $FunctionalProvider<N3KanjiRepository,
    N3KanjiRepository, N3KanjiRepository> with $Provider<N3KanjiRepository> {
  RepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'repositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$repositoryHash();

  @$internal
  @override
  $ProviderElement<N3KanjiRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  N3KanjiRepository create(Ref ref) {
    return repository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(N3KanjiRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<N3KanjiRepository>(value),
    );
  }
}

String _$repositoryHash() => r'07bd13ababc6dc50a4aded9596bc680c4c9f6187';

/// Toggle favourite status for a word.
/// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).

@ProviderFor(toggleFavourite)
final toggleFavouriteProvider = ToggleFavouriteFamily._();

/// Toggle favourite status for a word.
/// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).

final class ToggleFavouriteProvider
    extends $FunctionalProvider<AsyncValue<Word?>, Word?, FutureOr<Word?>>
    with $FutureModifier<Word?>, $FutureProvider<Word?> {
  /// Toggle favourite status for a word.
  /// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).
  ToggleFavouriteProvider._(
      {required ToggleFavouriteFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'toggleFavouriteProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$toggleFavouriteHash();

  @override
  String toString() {
    return r'toggleFavouriteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Word?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Word?> create(Ref ref) {
    final argument = this.argument as int;
    return toggleFavourite(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ToggleFavouriteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$toggleFavouriteHash() => r'ee1f82d18e26a599772f70c9bb566329dec38d11';

/// Toggle favourite status for a word.
/// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).

final class ToggleFavouriteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Word?>, int> {
  ToggleFavouriteFamily._()
      : super(
          retry: null,
          name: r'toggleFavouriteProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Toggle favourite status for a word.
  /// Call this from widgets using ref.read(toggleFavouriteProvider(wordId)).

  ToggleFavouriteProvider call(
    int wordId,
  ) =>
      ToggleFavouriteProvider._(argument: wordId, from: this);

  @override
  String toString() => r'toggleFavouriteProvider';
}

/// Fetch a single word by ID from DB

@ProviderFor(wordById)
final wordByIdProvider = WordByIdFamily._();

/// Fetch a single word by ID from DB

final class WordByIdProvider
    extends $FunctionalProvider<AsyncValue<Word?>, Word?, FutureOr<Word?>>
    with $FutureModifier<Word?>, $FutureProvider<Word?> {
  /// Fetch a single word by ID from DB
  WordByIdProvider._(
      {required WordByIdFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'wordByIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordByIdHash();

  @override
  String toString() {
    return r'wordByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Word?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Word?> create(Ref ref) {
    final argument = this.argument as int;
    return wordById(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordByIdHash() => r'47730dd34c37c7ae9b8be4b92a250cde5740a43c';

/// Fetch a single word by ID from DB

final class WordByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Word?>, int> {
  WordByIdFamily._()
      : super(
          retry: null,
          name: r'wordByIdProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Fetch a single word by ID from DB

  WordByIdProvider call(
    int wordId,
  ) =>
      WordByIdProvider._(argument: wordId, from: this);

  @override
  String toString() => r'wordByIdProvider';
}

/// Synchronous access to word by ID (for UI that needs immediate value)

@ProviderFor(wordByIdValue)
final wordByIdValueProvider = WordByIdValueFamily._();

/// Synchronous access to word by ID (for UI that needs immediate value)

final class WordByIdValueProvider
    extends $FunctionalProvider<Word?, Word?, Word?> with $Provider<Word?> {
  /// Synchronous access to word by ID (for UI that needs immediate value)
  WordByIdValueProvider._(
      {required WordByIdValueFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'wordByIdValueProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordByIdValueHash();

  @override
  String toString() {
    return r'wordByIdValueProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Word?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Word? create(Ref ref) {
    final argument = this.argument as int;
    return wordByIdValue(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Word? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Word?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordByIdValueProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordByIdValueHash() => r'35688c73eeef42ab2fae9ae469c3cb7341406a65';

/// Synchronous access to word by ID (for UI that needs immediate value)

final class WordByIdValueFamily extends $Family
    with $FunctionalFamilyOverride<Word?, int> {
  WordByIdValueFamily._()
      : super(
          retry: null,
          name: r'wordByIdValueProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Synchronous access to word by ID (for UI that needs immediate value)

  WordByIdValueProvider call(
    int wordId,
  ) =>
      WordByIdValueProvider._(argument: wordId, from: this);

  @override
  String toString() => r'wordByIdValueProvider';
}

/// Fetch words by kanji ID from DB

@ProviderFor(wordsByKanji)
final wordsByKanjiProvider = WordsByKanjiFamily._();

/// Fetch words by kanji ID from DB

final class WordsByKanjiProvider extends $FunctionalProvider<
        AsyncValue<List<Word>>, List<Word>, FutureOr<List<Word>>>
    with $FutureModifier<List<Word>>, $FutureProvider<List<Word>> {
  /// Fetch words by kanji ID from DB
  WordsByKanjiProvider._(
      {required WordsByKanjiFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'wordsByKanjiProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordsByKanjiHash();

  @override
  String toString() {
    return r'wordsByKanjiProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Word>> create(Ref ref) {
    final argument = this.argument as int;
    return wordsByKanji(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordsByKanjiProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordsByKanjiHash() => r'977fbfb41e01265aadd14eb22112733bb2c171d6';

/// Fetch words by kanji ID from DB

final class WordsByKanjiFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Word>>, int> {
  WordsByKanjiFamily._()
      : super(
          retry: null,
          name: r'wordsByKanjiProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Fetch words by kanji ID from DB

  WordsByKanjiProvider call(
    int kanjiId,
  ) =>
      WordsByKanjiProvider._(argument: kanjiId, from: this);

  @override
  String toString() => r'wordsByKanjiProvider';
}

/// Synchronous access to words by kanji (for UI that needs immediate value)

@ProviderFor(wordsByKanjiValue)
final wordsByKanjiValueProvider = WordsByKanjiValueFamily._();

/// Synchronous access to words by kanji (for UI that needs immediate value)

final class WordsByKanjiValueProvider
    extends $FunctionalProvider<List<Word>, List<Word>, List<Word>>
    with $Provider<List<Word>> {
  /// Synchronous access to words by kanji (for UI that needs immediate value)
  WordsByKanjiValueProvider._(
      {required WordsByKanjiValueFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'wordsByKanjiValueProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordsByKanjiValueHash();

  @override
  String toString() {
    return r'wordsByKanjiValueProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Word> create(Ref ref) {
    final argument = this.argument as int;
    return wordsByKanjiValue(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Word> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Word>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordsByKanjiValueProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordsByKanjiValueHash() => r'e9515c8467677a6683dccf7a9bc99a3aba565230';

/// Synchronous access to words by kanji (for UI that needs immediate value)

final class WordsByKanjiValueFamily extends $Family
    with $FunctionalFamilyOverride<List<Word>, int> {
  WordsByKanjiValueFamily._()
      : super(
          retry: null,
          name: r'wordsByKanjiValueProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Synchronous access to words by kanji (for UI that needs immediate value)

  WordsByKanjiValueProvider call(
    int kanjiId,
  ) =>
      WordsByKanjiValueProvider._(argument: kanjiId, from: this);

  @override
  String toString() => r'wordsByKanjiValueProvider';
}

/// Fetch words by lesson from DB

@ProviderFor(wordsByLesson)
final wordsByLessonProvider = WordsByLessonFamily._();

/// Fetch words by lesson from DB

final class WordsByLessonProvider extends $FunctionalProvider<
        AsyncValue<List<Word>>, List<Word>, FutureOr<List<Word>>>
    with $FutureModifier<List<Word>>, $FutureProvider<List<Word>> {
  /// Fetch words by lesson from DB
  WordsByLessonProvider._(
      {required WordsByLessonFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'wordsByLessonProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordsByLessonHash();

  @override
  String toString() {
    return r'wordsByLessonProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Word>> create(Ref ref) {
    final argument = this.argument as int;
    return wordsByLesson(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordsByLessonProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordsByLessonHash() => r'1ead628b5f6d8d05464adbcc72c90924331a435c';

/// Fetch words by lesson from DB

final class WordsByLessonFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Word>>, int> {
  WordsByLessonFamily._()
      : super(
          retry: null,
          name: r'wordsByLessonProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Fetch words by lesson from DB

  WordsByLessonProvider call(
    int lesson,
  ) =>
      WordsByLessonProvider._(argument: lesson, from: this);

  @override
  String toString() => r'wordsByLessonProvider';
}

/// Fetch paginated favourite words from DB

@ProviderFor(favouriteWordsPaginated)
final favouriteWordsPaginatedProvider = FavouriteWordsPaginatedFamily._();

/// Fetch paginated favourite words from DB

final class FavouriteWordsPaginatedProvider extends $FunctionalProvider<
        AsyncValue<PaginatedResult<Word>>,
        PaginatedResult<Word>,
        FutureOr<PaginatedResult<Word>>>
    with
        $FutureModifier<PaginatedResult<Word>>,
        $FutureProvider<PaginatedResult<Word>> {
  /// Fetch paginated favourite words from DB
  FavouriteWordsPaginatedProvider._(
      {required FavouriteWordsPaginatedFamily super.from,
      required ({
        int page,
        int pageSize,
      })
          super.argument})
      : super(
          retry: null,
          name: r'favouriteWordsPaginatedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favouriteWordsPaginatedHash();

  @override
  String toString() {
    return r'favouriteWordsPaginatedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<Word>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<Word>> create(Ref ref) {
    final argument = this.argument as ({
      int page,
      int pageSize,
    });
    return favouriteWordsPaginated(
      ref,
      page: argument.page,
      pageSize: argument.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FavouriteWordsPaginatedProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$favouriteWordsPaginatedHash() =>
    r'f22d98fbda2ef3d3038b8feca9cff62319c73e3b';

/// Fetch paginated favourite words from DB

final class FavouriteWordsPaginatedFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<PaginatedResult<Word>>,
            ({
              int page,
              int pageSize,
            })> {
  FavouriteWordsPaginatedFamily._()
      : super(
          retry: null,
          name: r'favouriteWordsPaginatedProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Fetch paginated favourite words from DB

  FavouriteWordsPaginatedProvider call({
    int page = 1,
    int pageSize = 50,
  }) =>
      FavouriteWordsPaginatedProvider._(argument: (
        page: page,
        pageSize: pageSize,
      ), from: this);

  @override
  String toString() => r'favouriteWordsPaginatedProvider';
}

/// Fetch paginated words with filters from DB

@ProviderFor(wordsPaginated)
final wordsPaginatedProvider = WordsPaginatedFamily._();

/// Fetch paginated words with filters from DB

final class WordsPaginatedProvider extends $FunctionalProvider<
        AsyncValue<PaginatedResult<Word>>,
        PaginatedResult<Word>,
        FutureOr<PaginatedResult<Word>>>
    with
        $FutureModifier<PaginatedResult<Word>>,
        $FutureProvider<PaginatedResult<Word>> {
  /// Fetch paginated words with filters from DB
  WordsPaginatedProvider._(
      {required WordsPaginatedFamily super.from,
      required ({
        int page,
        int pageSize,
        WordSearchFilters filters,
      })
          super.argument})
      : super(
          retry: null,
          name: r'wordsPaginatedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wordsPaginatedHash();

  @override
  String toString() {
    return r'wordsPaginatedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<Word>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<Word>> create(Ref ref) {
    final argument = this.argument as ({
      int page,
      int pageSize,
      WordSearchFilters filters,
    });
    return wordsPaginated(
      ref,
      page: argument.page,
      pageSize: argument.pageSize,
      filters: argument.filters,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WordsPaginatedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordsPaginatedHash() => r'0d45acb1a8ff2f4b43b38da358f6f4f289b814d7';

/// Fetch paginated words with filters from DB

final class WordsPaginatedFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<PaginatedResult<Word>>,
            ({
              int page,
              int pageSize,
              WordSearchFilters filters,
            })> {
  WordsPaginatedFamily._()
      : super(
          retry: null,
          name: r'wordsPaginatedProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Fetch paginated words with filters from DB

  WordsPaginatedProvider call({
    int page = 1,
    int pageSize = 50,
    WordSearchFilters filters = const WordSearchFilters(),
  }) =>
      WordsPaginatedProvider._(argument: (
        page: page,
        pageSize: pageSize,
        filters: filters,
      ), from: this);

  @override
  String toString() => r'wordsPaginatedProvider';
}

@ProviderFor(LessonSelection)
final lessonSelectionProvider = LessonSelectionProvider._();

final class LessonSelectionProvider
    extends $AsyncNotifierProvider<LessonSelection, LessonSelectionData> {
  LessonSelectionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonSelectionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonSelectionHash();

  @$internal
  @override
  LessonSelection create() => LessonSelection();
}

String _$lessonSelectionHash() => r'22debdc414603335150d7a609065587dd48c9004';

abstract class _$LessonSelection extends $AsyncNotifier<LessonSelectionData> {
  FutureOr<LessonSelectionData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LessonSelectionData>, LessonSelectionData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<LessonSelectionData>, LessonSelectionData>,
        AsyncValue<LessonSelectionData>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
