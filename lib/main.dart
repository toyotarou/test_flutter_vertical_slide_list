import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Date Flip + Drag Scroll Bar',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const CardFlipListPage(),
    );
  }
}

//////////////////////////////////////////////////////////

class CardFlipListPage extends StatefulWidget {
  const CardFlipListPage({super.key});

  ///
  @override
  State<CardFlipListPage> createState() => _CardFlipListPageState();
}

//-----

class _CardFlipListPageState extends State<CardFlipListPage> {
  final ScrollController _scrollController = ScrollController();

  static const double _dragToScrollScale = 2.2;

  int _cardCount = 8;

  late DateTime _baseDate;

  late DateTime _pendingDate;

  final List<int> _offsets = <int>[];

  int _applyTick = 0;

  ///
  @override
  void initState() {
    super.initState();
    _baseDate = _stripTime(DateTime.now());
    _pendingDate = _baseDate;

    _syncOffsetsLength();
  }

  ///
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///
  DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);

  ///
  String _formatDate(DateTime d) {
    final String y = d.year.toString().padLeft(4, '0');
    final String m = d.month.toString().padLeft(2, '0');
    final String day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  ///
  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) {
      return;
    }

    final ScrollPosition position = _scrollController.position;
    final double newOffset = (_scrollController.offset + delta).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    _scrollController.jumpTo(newOffset);
  }

  ///
  void _syncOffsetsLength() {
    if (_offsets.length < _cardCount) {
      _offsets.addAll(List<int>.filled(_cardCount - _offsets.length, 0));
    } else if (_offsets.length > _cardCount) {
      _offsets.removeRange(_cardCount, _offsets.length);
    }
  }

  ///
  void _setCardCount(int value) {
    setState(() {
      _cardCount = value.clamp(1, 200);
      _syncOffsetsLength();
    });
  }

  ///
  void _setOffset(int index, int newOffset) {
    if (index < 0 || index >= _offsets.length) {
      return;
    }
    setState(() => _offsets[index] = newOffset);
  }

  ///
  void _shiftPendingBy(int deltaDays) {
    setState(() {
      _pendingDate = _stripTime(_pendingDate.add(Duration(days: deltaDays)));
    });
  }

  ///
  void _applyPendingToAll() {
    setState(() {
      _baseDate = _pendingDate;
      for (int i = 0; i < _offsets.length; i++) {
        _offsets[i] = 0;
      }
      _applyTick++;
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    // ====== 変更: 子カードの変更も dirty 扱いにする ======
    final bool anyChildDirty = _offsets.any((int v) => v != 0);
    final bool globalDirty = _formatDate(_pendingDate) != _formatDate(_baseDate);
    final bool isDirty = globalDirty || anyChildDirty;

    final String helperText = isDirty ? '適用を押すと、すべてのカードがこの日付に揃います（子カードのズレもリセット）' : '上下スワイプで日付変更（現在は全カードと同じ）';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _GlobalFlipCard(
              label: '全体',
              date: _pendingDate,
              onSwipeUp: () => _shiftPendingBy(1),
              onSwipeDown: () => _shiftPendingBy(-1),
              onApply: isDirty ? _applyPendingToAll : null,
              helperText: helperText,
            ),

            _TopControls(
              cardCount: _cardCount,
              onMinus: () => _setCardCount(_cardCount - 1),
              onPlus: () => _setCardCount(_cardCount + 1),
              onSliderChanged: (double v) => _setCardCount(v.round()),
            ),

            const Divider(height: 1),

            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
                          itemCount: _cardCount,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (BuildContext context, int index) {
                            final DateTime currentDate = _baseDate.add(Duration(days: _offsets[index]));

                            return DateFlipCard(
                              label: 'card${index + 1}',
                              displayedDate: currentDate,
                              currentOffset: _offsets[index],
                              onOffsetChanged: (int newOffset) => _setOffset(index, newOffset),
                              externalTargetDate: _baseDate,
                              applyTick: _applyTick,
                            );
                          },
                        ),
                      ),

                      _DragScrollBar(
                        onDragDelta: (double dy) {
                          _scrollBy(dy * _dragToScrollScale);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class _TopControls extends StatelessWidget {
  const _TopControls({
    required this.cardCount,
    required this.onMinus,
    required this.onPlus,
    required this.onSliderChanged,
  });

  final int cardCount;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final ValueChanged<double> onSliderChanged;

  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
      child: Row(
        children: <Widget>[
          FilledButton.tonal(onPressed: cardCount > 1 ? onMinus : null, child: const Text('-')),
          const SizedBox(width: 8),
          FilledButton.tonal(onPressed: onPlus, child: const Text('+')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('カード枚数: $cardCount', style: const TextStyle(fontWeight: FontWeight.w700)),
                Slider(
                  value: cardCount.toDouble(),
                  min: 1,
                  max: 40,
                  divisions: 39,
                  label: '$cardCount',
                  onChanged: onSliderChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class _DragScrollBar extends StatelessWidget {
  const _DragScrollBar({required this.onDragDelta});

  final void Function(double dy) onDragDelta;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      margin: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC58A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: (DragUpdateDetails details) => onDragDelta(details.delta.dy),
        child: const Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Text('DRAG', style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 2)),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class _GlobalFlipCard extends StatelessWidget {
  const _GlobalFlipCard({
    required this.label,
    required this.date,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.onApply,
    required this.helperText,
  });

  final String label;
  final DateTime date;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final VoidCallback? onApply;
  final String helperText;

  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Container(
                width: 84,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GlobalFlipBody(
                  date: date,
                  onSwipeUp: onSwipeUp,
                  onSwipeDown: onSwipeDown,
                  helperText: helperText,
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(onPressed: onApply, child: const Text('適用')),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////

class _GlobalFlipBody extends StatefulWidget {
  const _GlobalFlipBody({
    required this.date,
    required this.onSwipeUp,
    required this.onSwipeDown,
    required this.helperText,
  });

  final DateTime date;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;
  final String helperText;

  ///
  @override
  State<_GlobalFlipBody> createState() => _GlobalFlipBodyState();
}

//-----

class _GlobalFlipBodyState extends State<_GlobalFlipBody> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late String _frontText;
  String? _nextText;
  int _flipDirection = 1;

  static const double _swipeThreshold = 24;
  double _dragDy = 0;

  ///
  DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);

  ///
  String _formatDate(DateTime d) {
    final String y = d.year.toString().padLeft(4, '0');
    final String m = d.month.toString().padLeft(2, '0');
    final String day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  ///
  @override
  void initState() {
    super.initState();
    _frontText = _formatDate(_stripTime(widget.date));
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (_nextText != null) {
          setState(() {
            _frontText = _nextText!;
            _nextText = null;
          });
        }
        _controller.reset();
      }
    });
  }

  ///
  @override
  void didUpdateWidget(covariant _GlobalFlipBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    final String newText = _formatDate(_stripTime(widget.date));
    if (_frontText != newText && !_controller.isAnimating) {
      setState(() => _frontText = newText);
    }
  }

  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
  Future<void> _flipToText(String next, {required int direction}) async {
    if (_controller.isAnimating) {
      return;
    }

    setState(() {
      _nextText = next;
      _flipDirection = direction;
    });
    await _controller.forward();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (_) => _dragDy = 0,
      onVerticalDragUpdate: (DragUpdateDetails details) => _dragDy += details.delta.dy,
      onVerticalDragEnd: (_) async {
        if (_controller.isAnimating) {
          return;
        }

        if (_dragDy <= -_swipeThreshold) {
          final DateTime nextDate = _stripTime(widget.date.add(const Duration(days: 1)));
          final String nextText = _formatDate(nextDate);
          await _flipToText(nextText, direction: 1);
          widget.onSwipeUp();
        } else if (_dragDy >= _swipeThreshold) {
          final DateTime prevDate = _stripTime(widget.date.subtract(const Duration(days: 1)));
          final String prevText = _formatDate(prevDate);
          await _flipToText(prevText, direction: -1);
          widget.onSwipeDown();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _FlipDateText(
            controller: _controller,
            frontText: _frontText,
            nextText: _nextText,
            direction: _flipDirection,
            leadingIcon: Icons.public,
          ),
          const SizedBox(height: 6),
          Text(
            widget.helperText,
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class DateFlipCard extends StatefulWidget {
  const DateFlipCard({
    super.key,
    required this.label,
    required this.displayedDate,
    required this.currentOffset,
    required this.onOffsetChanged,
    required this.externalTargetDate,
    required this.applyTick,
  });

  final String label;

  final DateTime displayedDate;

  final int currentOffset;

  final ValueChanged<int> onOffsetChanged;

  final DateTime externalTargetDate;

  final int applyTick;

  @override
  State<DateFlipCard> createState() => _DateFlipCardState();
}

//-----

class _DateFlipCardState extends State<DateFlipCard> with SingleTickerProviderStateMixin {
  late DateTime _shownDate;

  late final AnimationController _controller;

  late String _frontText;
  String? _nextText;

  int _flipDirection = 1;

  static const double _swipeThreshold = 24;
  double _dragDy = 0;

  int _lastApplyTick = 0;

  ///
  @override
  void initState() {
    super.initState();

    _shownDate = _stripTime(widget.displayedDate);
    _frontText = _formatDate(_shownDate);

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (_nextText != null) {
          setState(() {
            _frontText = _nextText!;
            _nextText = null;
          });
        }
        _controller.reset();
      }
    });

    _lastApplyTick = widget.applyTick;
  }

  ///
  @override
  void didUpdateWidget(covariant DateFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.applyTick != _lastApplyTick) {
      _lastApplyTick = widget.applyTick;

      final DateTime target = _stripTime(widget.externalTargetDate);
      final String targetText = _formatDate(target);

      if (_frontText != targetText) {
        final int diff = target.difference(_shownDate).inDays;
        final int dir = diff >= 0 ? 1 : -1;

        _flipTo(target, direction: dir);
      } else {
        _shownDate = target;
        _nextText = null;
      }
      return;
    }

    final DateTime newDate = _stripTime(widget.displayedDate);
    final String newText = _formatDate(newDate);
    if (_frontText != newText && !_controller.isAnimating) {
      _shownDate = newDate;
      _frontText = newText;
      _nextText = null;
      setState(() {});
    }
  }

  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
  DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);

  ///
  String _formatDate(DateTime d) {
    final String y = d.year.toString().padLeft(4, '0');
    final String m = d.month.toString().padLeft(2, '0');
    final String day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  ///
  Future<void> _flipTo(DateTime newDate, {required int direction}) async {
    if (_controller.isAnimating) {
      return;
    }

    final String next = _formatDate(newDate);
    setState(() {
      _nextText = next;
      _flipDirection = direction;
      _shownDate = newDate;
    });

    await _controller.forward();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (_) => _dragDy = 0,
      onVerticalDragUpdate: (DragUpdateDetails details) {
        _dragDy += details.delta.dy;
      },
      onVerticalDragEnd: (_) {
        if (_controller.isAnimating) {
          return;
        }

        if (_dragDy <= -_swipeThreshold) {
          final int newOffset = widget.currentOffset + 1;
          widget.onOffsetChanged(newOffset);

          final DateTime next = _stripTime(widget.displayedDate.add(const Duration(days: 1)));
          _flipTo(next, direction: 1);
        } else if (_dragDy >= _swipeThreshold) {
          final int newOffset = widget.currentOffset - 1;
          widget.onOffsetChanged(newOffset);

          final DateTime prev = _stripTime(widget.displayedDate.subtract(const Duration(days: 1)));
          _flipTo(prev, direction: -1);
        }
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          height: 72,
          child: Row(
            children: <Widget>[
              Container(
                width: 84,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: const Border(right: BorderSide(color: Color(0x22000000))),
                ),
                child: Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: _FlipDateText(
                    controller: _controller,
                    frontText: _frontText,
                    nextText: _nextText,
                    direction: _flipDirection,
                    leadingIcon: Icons.event,
                  ),
                ),
              ),
              const _SwipeHint(),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class _SwipeHint extends StatelessWidget {
  const _SwipeHint();

  ///
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 44,
      height: 72,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_up, size: 18),
              SizedBox(height: 2),
              Text('明日', style: TextStyle(fontSize: 11)),
              SizedBox(height: 6),
              Text('昨日', style: TextStyle(fontSize: 11)),
              SizedBox(height: 2),
              Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////

class _FlipDateText extends StatelessWidget {
  const _FlipDateText({
    required this.controller,
    required this.frontText,
    required this.nextText,
    required this.direction,
    required this.leadingIcon,
  });

  final AnimationController controller;
  final String frontText;
  final String? nextText;
  final int direction;
  final IconData leadingIcon;

  ///
  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle = Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800);

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) {
        final double t = controller.value.clamp(0.0, 1.0);

        final double angle = t * math.pi;

        final bool showingNext = t >= 0.5 && nextText != null;
        final String text = showingNext ? nextText! : frontText;

        final double correctedAngle = showingNext ? (angle - math.pi) : angle;

        final double signedAngle = correctedAngle * direction;

        final Matrix4 m = Matrix4.identity()
          ..setEntry(3, 2, 0.0018)
          ..rotateX(signedAngle);

        final double fade = math.cos(angle).abs().clamp(0.0, 1.0);

        return Transform(
          alignment: Alignment.centerLeft,
          transform: m,
          child: Opacity(
            opacity: 0.2 + fade * 0.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(leadingIcon, size: 18),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(text, style: baseStyle, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
