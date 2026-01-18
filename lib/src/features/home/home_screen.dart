import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../state/providers.dart';
import '../../utils/furigana_util.dart';
import '../../widgets/widgets.dart';
import 'flashcards_tab.dart';
import 'home_providers.dart';
import 'lesson_data.dart';
import 'lesson_drawer.dart';
import 'quiz_tab.dart';
import 'study_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();

  String _screenTitle(int lesson) {
    // Get actual lesson name with numbering
    final lessonIndex = lesson - 1;
    if (lessonIndex >= 0 && lessonIndex < names.length) {
      final mTitle = '$lesson. ${names[lessonIndex]}';
      return furiganaOriginalText(
          mTitle.isNotEmpty ? mTitle : 'Lesson $lesson');
    }
    // Fallback to lesson number if not found
    return 'Lesson $lesson';
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Preload providers to reduce splash screen delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lessonSelectionProvider.future);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selection = ref.watch(lessonSelectionValueProvider);

    final title = widget._screenTitle(selection.lesson);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(title),
      ),
      drawer: LessonDrawer(
        currentLesson: selection.lesson,
        onSelect: (lesson) async {
          if (lesson == selection.lesson) {
            if (context.mounted) Navigator.of(context).pop();
            return;
          }
          await ref.read(lessonSelectionProvider.notifier).setLesson(lesson);
          await ref.read(selectedKanjiIdProvider.notifier).setSelectedId(null);
          ref.invalidate(kanjiListProvider);
          ref.invalidate(selectedKanjiIdProvider);
          setState(() => _tabIndex = 0);
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
      body: _MainBody(
        tabIndex: _tabIndex,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AdBanner(useSafeArea: false),
          BottomNavigationBar(
            currentIndex: _tabIndex,
            onTap: (index) => setState(() => _tabIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Study',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.style),
                label: 'Flash Card',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quiz',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MainBody extends ConsumerWidget {
  const _MainBody({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tabIndex == 0) {
      return const StudyTab();
    }

    final lessonWordsAsync = ref.watch(lessonWordsProvider);
    return lessonWordsAsync.when(
      data: (lessonWords) {
        if (tabIndex == 1) {
          return FlashcardsTab(words: lessonWords);
        }
        // Use lesson words as fallback pool for quiz options (same context, memory efficient)
        return QuizTab(words: lessonWords, allWords: lessonWords);
      },
      error: (e, st) => ErrorView(message: e.toString()),
      loading: () => const LoadingIndicator(),
    );
  }
}
