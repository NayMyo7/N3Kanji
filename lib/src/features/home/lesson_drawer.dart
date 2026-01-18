import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../widgets/furigana_text.dart';
import 'lesson_data.dart';

class LessonDrawer extends StatefulWidget {
  const LessonDrawer({
    required this.currentLesson,
    required this.onSelect,
    super.key,
  });

  final int currentLesson;
  final Future<void> Function(int lesson) onSelect;

  @override
  State<LessonDrawer> createState() => _LessonDrawerState();
}

class _LessonDrawerState extends State<LessonDrawer> {
  late int _selectedLesson;

  @override
  void initState() {
    super.initState();
    _selectedLesson = widget.currentLesson;
  }

  @override
  void didUpdateWidget(covariant LessonDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLesson != widget.currentLesson) {
      _selectedLesson = widget.currentLesson;
    }
  }

  @override
  Widget build(BuildContext context) {
    const dividerColor = AppColors.divider;
    const headerHorizontalPadding = AppSizes.md;

    final lessonStyle = Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700);

    return Drawer(
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.lg,
                    vertical: AppSizes.xl,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '日本語総まとめ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      Text(
                        'N3 漢字',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: names.length, // Only show available lessons
                itemBuilder: (context, index) {
                  final lesson = index + 1;
                  final isSelected = _selectedLesson == lesson;

                  return Column(
                    children: [
                      if (index != 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor,
                        ),
                      ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: headerHorizontalPadding,
                        ),
                        selected: isSelected,
                        title: FuriganaText(
                          '$lesson. ${names[index]}',
                          baseStyle: lessonStyle?.copyWith(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            fontWeight:
                                isSelected ? FontWeight.w900 : FontWeight.w700,
                          ),
                        ),
                        onTap: () async {
                          setState(() {
                            _selectedLesson = lesson;
                          });
                          await widget.onSelect(lesson);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(height: 1, thickness: 1, color: dividerColor),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: AppSizes.s6,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => context.push('/about'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s6,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.info_outline, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              'About',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => context.push('/favourites'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s6,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_border, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              'Favourites',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => context.push('/search'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.s6,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.search_outlined, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              'Search',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
