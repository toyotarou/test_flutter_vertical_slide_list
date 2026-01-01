import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//////////////////////////////////////////////////////////

class FundRow {
  FundRow({
    required this.date,
    required this.fundId,
    required this.name,
    required this.investedYen,
    required this.valuationYen,
  });

  final DateTime date;
  final int fundId;
  final String name;
  final int investedYen;
  final int valuationYen;

  int get profitYen => valuationYen - investedYen;
}

//////////////////////////////////////////////////////////

class FundGroup {
  FundGroup({required this.fundId, required this.name, required this.rows});

  final int fundId;
  final String name;
  final List<FundRow> rows;

  List<FundRow> rowsOfDate(DateTime d) {
    final DateTime key = DateTime(d.year, d.month, d.day);
    return rows.where((FundRow r) => _stripTime(r.date) == key).toList();
  }

  static DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);
}

//////////////////////////////////////////////////////////

///
const String kFundTsv = '''
2025	1	6	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	390,000 円	599,552 円
2025	1	6	106	eMAXIS Slim 米国株式(S&P500)	389,999 円	608,440 円
2025	1	6	118	iFree S&P500インデックス	20,000 円	20,380 円
2025	1	6	107	iFreeNEXT インド株インデックス	170,000 円	186,952 円
2025	1	6	108	iTrust インド株式	169,999 円	201,746 円
2025	1	6	109	たわらノーロード S&P500 - NISAつみたて投資枠	39,996 円	47,399 円
2025	1	6	110	eMAXIS Slim 米国株式(S&P500)	139,999 円	157,682 円
2025	1	6	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	28,121 円
2025	1	6	112	iFree S&P500インデックス	540,000 円	612,375 円
2025	1	6	113	NZAM・ベータ S&P500	269,999 円	304,271 円
2025	1	6	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	113,060 円
2025	1	6	115	iFree S&P500インデックス	99,999 円	108,610 円
2025	1	6	116	たわらノーロード S&P500	40,000 円	58,531 円
2025	1	6	117	iFree S&P500インデックス	909,999 円	1,602,806 円
2025	1	7	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	390,000 円	595,746 円
2025	1	7	106	eMAXIS Slim 米国株式(S&P500)	389,999 円	603,918 円
2025	1	7	118	iFree S&P500インデックス	20,000 円	20,228 円
2025	1	7	107	iFreeNEXT インド株インデックス	170,000 円	187,330 円
2025	1	7	108	iTrust インド株式	169,999 円	201,947 円
2025	1	7	109	たわらノーロード S&P500 - NISAつみたて投資枠	39,996 円	47,047 円
2025	1	7	110	eMAXIS Slim 米国株式(S&P500)	139,999 円	156,510 円
2025	1	7	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,904 円
2025	1	7	112	iFree S&P500インデックス	540,000 円	607,795 円
2025	1	7	113	NZAM・ベータ S&P500	269,999 円	301,975 円
2025	1	7	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	112,220 円
2025	1	7	115	iFree S&P500インデックス	99,999 円	107,798 円
2025	1	7	116	たわらノーロード S&P500	40,000 円	58,097 円
2025	1	7	117	iFree S&P500インデックス	909,999 円	1,590,819 円
2025	1	8	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	390,000 円	600,954 円
2025	1	8	106	eMAXIS Slim 米国株式(S&P500)	389,999 円	609,223 円
2025	1	8	118	iFree S&P500インデックス	20,000 円	20,404 円
2025	1	8	107	iFreeNEXT インド株インデックス	170,000 円	184,660 円
2025	1	8	108	iTrust インド株式	169,999 円	200,091 円
2025	1	8	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	50,791 円
2025	1	8	110	eMAXIS Slim 米国株式(S&P500)	159,999 円	177,886 円
2025	1	8	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	28,205 円
2025	1	8	112	iFree S&P500インデックス	540,000 円	613,101 円
2025	1	8	113	NZAM・ベータ S&P500	269,999 円	304,612 円
2025	1	8	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	113,206 円
2025	1	8	115	iFree S&P500インデックス	99,999 円	108,739 円
2025	1	8	116	たわらノーロード S&P500	40,000 円	58,603 円
2025	1	8	117	iFree S&P500インデックス	909,999 円	1,604,706 円
2025	1	9	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	390,000 円	593,756 円
2025	1	9	106	eMAXIS Slim 米国株式(S&P500)	389,999 円	601,978 円
2025	1	9	118	iFree S&P500インデックス	20,000 円	20,161 円
2025	1	9	107	iFreeNEXT インド株インデックス	170,000 円	185,148 円
2025	1	9	108	iTrust インド株式	169,999 円	201,697 円
2025	1	9	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	50,187 円
2025	1	9	110	eMAXIS Slim 米国株式(S&P500)	159,999 円	175,771 円
2025	1	9	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,950 円
2025	1	9	112	iFree S&P500インデックス	540,000 円	605,796 円
2025	1	9	113	NZAM・ベータ S&P500	269,999 円	300,997 円
2025	1	9	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	111,860 円
2025	1	9	115	iFree S&P500インデックス	99,999 円	107,443 円
2025	1	9	116	たわらノーロード S&P500	40,000 円	57,907 円
2025	1	9	117	iFree S&P500インデックス	909,999 円	1,585,585 円
2025	1	10	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	604,640 円
2025	1	10	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	613,226 円
2025	1	10	118	iFree S&P500インデックス	20,000 円	20,204 円
2025	1	10	107	iFreeNEXT インド株インデックス	180,000 円	193,819 円
2025	1	10	108	iTrust インド株式	180,000 円	208,747 円
2025	1	10	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	50,295 円
2025	1	10	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	186,124 円
2025	1	10	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,931 円
2025	1	10	112	iFree S&P500インデックス	560,000 円	627,040 円
2025	1	10	113	NZAM・ベータ S&P500	300,000 円	331,575 円
2025	1	10	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	112,095 円
2025	1	10	115	iFree S&P500インデックス	99,999 円	107,669 円
2025	1	10	116	たわらノーロード S&P500	40,000 円	58,032 円
2025	1	10	117	iFree S&P500インデックス	909,999 円	1,588,919 円
2025	1	14	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	604,640 円
2025	1	14	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	613,226 円
2025	1	14	118	iFree S&P500インデックス	20,000 円	20,204 円
2025	1	14	107	iFreeNEXT インド株インデックス	180,000 円	193,819 円
2025	1	14	108	iTrust インド株式	180,000 円	208,747 円
2025	1	14	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	50,295 円
2025	1	14	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	186,124 円
2025	1	14	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,931 円
2025	1	14	112	iFree S&P500インデックス	560,000 円	627,040 円
2025	1	14	113	NZAM・ベータ S&P500	300,000 円	331,575 円
2025	1	14	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	112,095 円
2025	1	14	115	iFree S&P500インデックス	99,999 円	107,669 円
2025	1	14	116	たわらノーロード S&P500	40,000 円	58,032 円
2025	1	14	117	iFree S&P500インデックス	909,999 円	1,588,919 円
2025	1	15	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	594,208 円
2025	1	15	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	602,478 円
2025	1	15	118	iFree S&P500インデックス	20,000 円	19,850 円
2025	1	15	107	iFreeNEXT インド株インデックス	180,000 円	187,818 円
2025	1	15	108	iTrust インド株式	180,000 円	200,160 円
2025	1	15	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	49,413 円
2025	1	15	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	182,862 円
2025	1	15	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,394 円
2025	1	15	112	iFree S&P500インデックス	560,000 円	616,063 円
2025	1	15	113	NZAM・ベータ S&P500	300,000 円	325,775 円
2025	1	15	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	110,130 円
2025	1	15	115	iFree S&P500インデックス	99,999 円	105,784 円
2025	1	15	116	たわらノーロード S&P500	40,000 円	57,013 円
2025	1	15	117	iFree S&P500インデックス	909,999 円	1,561,104 円
2025	1	16	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	597,462 円
2025	1	16	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	605,138 円
2025	1	16	118	iFree S&P500インデックス	39,999 円	39,938 円
2025	1	16	107	iFreeNEXT インド株インデックス	180,000 円	188,898 円
2025	1	16	108	iTrust インド株式	180,000 円	201,720 円
2025	1	16	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	49,632 円
2025	1	16	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	183,669 円
2025	1	16	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,567 円
2025	1	16	112	iFree S&P500インデックス	560,000 円	618,778 円
2025	1	16	113	NZAM・ベータ S&P500	300,000 円	327,225 円
2025	1	16	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	110,616 円
2025	1	16	115	iFree S&P500インデックス	99,999 円	106,251 円
2025	1	16	116	たわらノーロード S&P500	40,000 円	57,266 円
2025	1	16	117	iFree S&P500インデックス	909,999 円	1,567,984 円
2025	1	17	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	602,195 円
2025	1	17	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	609,951 円
2025	1	17	118	iFree S&P500インデックス	39,999 円	40,256 円
2025	1	17	107	iFreeNEXT インド株インデックス	180,000 円	187,960 円
2025	1	17	108	iTrust インド株式	180,000 円	201,516 円
2025	1	17	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	50,028 円
2025	1	17	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	185,130 円
2025	1	17	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,699 円
2025	1	17	112	iFree S&P500インデックス	560,000 円	623,708 円
2025	1	17	113	NZAM・ベータ S&P500	300,000 円	329,812 円
2025	1	17	119	たわらノーロード 先進国株式	9,999 円	10,003 円
2025	1	17	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	111,496 円
2025	1	17	115	iFree S&P500インデックス	99,999 円	107,097 円
2025	1	17	116	たわらノーロード S&P500	40,000 円	57,723 円
2025	1	17	117	iFree S&P500インデックス	909,999 円	1,580,478 円
2025	1	20	105	楽天・全米株式インデックス・ファンド(楽天・VTI)	399,999 円	597,075 円
2025	1	20	106	eMAXIS Slim 米国株式(S&P500)	399,999 円	603,962 円
2025	1	20	118	iFree S&P500インデックス	39,999 円	39,860 円
2025	1	20	107	iFreeNEXT インド株インデックス	180,000 円	186,816 円
2025	1	20	108	iTrust インド株式	180,000 円	200,016 円
2025	1	20	109	たわらノーロード S&P500 - NISAつみたて投資枠	43,329 円	49,535 円
2025	1	20	110	eMAXIS Slim 米国株式(S&P500)	170,000 円	183,312 円
2025	1	20	111	eMAXIS Slim 全世界株式(オール・カントリー)	26,667 円	27,528 円
2025	1	20	112	iFree S&P500インデックス	560,000 円	617,579 円
2025	1	20	113	NZAM・ベータ S&P500	300,000 円	326,575 円
2025	1	20	119	たわらノーロード 先進国株式	9,999 円	9,932 円
2025	1	20	114	eMAXIS Slim 米国株式(S&P500)	99,999 円	110,401 円
2025	1	20	115	iFree S&P500インデックス	99,999 円	106,045 円
2025	1	20	116	たわらノーロード S&P500	40,000 円	57,155 円
2025	1	20	117	iFree S&P500インデックス	909,999 円	1,564,945 円
''';

//////////////////////////////////////////////////////////

List<FundGroup> parseFundGroupsFromTsv(String tsv) {
  final List<String> lines = tsv.split('\n').map((String e) => e.trim()).where((String e) => e.isNotEmpty).toList();

  final List<FundRow> rows = <FundRow>[];

  for (final String line in lines) {
    final List<String> parts = line.split('\t');
    if (parts.length < 7) {
      continue;
    }

    final int? year = int.tryParse(parts[0].trim());
    final int? month = int.tryParse(parts[1].trim());
    final int? day = int.tryParse(parts[2].trim());
    final int? id = int.tryParse(parts[3].trim());
    final String name = parts[4].trim();

    final int invested = _parseYenToInt(parts[5]);
    final int valuation = _parseYenToInt(parts[6]);

    if (year == null || month == null || day == null || id == null) {
      continue;
    }

    rows.add(
      FundRow(date: DateTime(year, month, day), fundId: id, name: name, investedYen: invested, valuationYen: valuation),
    );
  }

  final Map<int, List<FundRow>> byId = <int, List<FundRow>>{};
  for (final FundRow r in rows) {
    byId.putIfAbsent(r.fundId, () => <FundRow>[]).add(r);
  }

  final List<FundGroup> groups = <FundGroup>[];
  final List<int> ids = byId.keys.toList()..sort();

  for (final int id in ids) {
    final List<FundRow> list = byId[id]!..sort((FundRow a, FundRow b) => a.date.compareTo(b.date));
    final String groupName = list.isNotEmpty ? list.first.name : 'ID $id';

    groups.add(FundGroup(fundId: id, name: groupName, rows: list));
  }

  return groups;
}

//////////////////////////////////////////////////////////

int _parseYenToInt(String s) {
  final String digits = RegExp(r'\d+').allMatches(s).map((RegExpMatch m) => m.group(0)!).join();
  return int.tryParse(digits) ?? 0;
}

//////////////////////////////////////////////////////////

String formatYen(int v) {
  final String s = v.toString();
  final StringBuffer sb = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final int idxFromEnd = s.length - i;
    sb.write(s[i]);
    if (idxFromEnd > 1 && idxFromEnd % 3 == 1) {
      sb.write(',');
    }
  }
  return '$sb 円';
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

  late final List<FundGroup> _groups;

  int _visibleCount = 8;

  late DateTime _baseDate;
  late DateTime _pendingDate;

  final List<int> _offsets = <int>[];

  int _applyTick = 0;

  ///
  @override
  void initState() {
    super.initState();

    _groups = parseFundGroupsFromTsv(kFundTsv);

    if (_groups.isNotEmpty && _groups.first.rows.isNotEmpty) {
      final DateTime minDate = _groups
          .expand((FundGroup g) => g.rows)
          .map((FundRow r) => DateTime(r.date.year, r.date.month, r.date.day))
          .reduce((DateTime a, DateTime b) => a.isBefore(b) ? a : b);
      _baseDate = _stripTime(minDate);
    } else {
      _baseDate = _stripTime(DateTime.now());
    }

    _pendingDate = _baseDate;

    _visibleCount = math.min(_visibleCount, _groups.length.clamp(1, 9999));
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
    if (_offsets.length < _visibleCount) {
      _offsets.addAll(List<int>.filled(_visibleCount - _offsets.length, 0));
    } else if (_offsets.length > _visibleCount) {
      _offsets.removeRange(_visibleCount, _offsets.length);
    }
  }

  ///
  void _setVisibleCount(int value) {
    setState(() {
      final int maxCount = _groups.length.clamp(1, 9999);
      _visibleCount = value.clamp(1, maxCount);
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
    final bool anyChildDirty = _offsets.any((int v) => v != 0);
    final bool globalDirty = _formatDate(_pendingDate) != _formatDate(_baseDate);
    final bool isDirty = globalDirty || anyChildDirty;

    final String helperText = isDirty ? '適用を押すと、すべてのカードがこの日付に揃います（子カードのズレもリセット）' : '上下スワイプで日付変更（現在は全カードと同じ）';

    final int maxCount = _groups.length.clamp(1, 9999);
    final int itemCount = _visibleCount.clamp(1, maxCount);

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
              visibleCount: itemCount,
              maxCount: maxCount,
              onMinus: () => _setVisibleCount(itemCount - 1),
              onPlus: () => _setVisibleCount(itemCount + 1),
              onSliderChanged: (double v) => _setVisibleCount(v.round()),
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
                          itemCount: itemCount,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (BuildContext context, int index) {
                            final FundGroup group = _groups[index];

                            final DateTime currentDate = _baseDate.add(Duration(days: _offsets[index]));
                            final List<FundRow> dayRows = group.rowsOfDate(currentDate);

                            return DateFlipCard(
                              fundId: group.fundId,
                              fundName: group.name,
                              displayedDate: currentDate,
                              dayRows: dayRows,
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
    required this.visibleCount,
    required this.maxCount,
    required this.onMinus,
    required this.onPlus,
    required this.onSliderChanged,
  });

  final int visibleCount;
  final int maxCount;
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
          FilledButton.tonal(onPressed: visibleCount > 1 ? onMinus : null, child: const Text('-')),
          const SizedBox(width: 8),
          FilledButton.tonal(onPressed: visibleCount < maxCount ? onPlus : null, child: const Text('+')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('表示カード数（ID数）: $visibleCount / $maxCount', style: const TextStyle(fontWeight: FontWeight.w700)),
                Slider(
                  value: visibleCount.toDouble(),
                  min: 1,
                  max: maxCount.toDouble(),
                  divisions: (maxCount - 1).clamp(1, 200),
                  label: '$visibleCount',
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
    required this.fundId,
    required this.fundName,
    required this.displayedDate,
    required this.dayRows,
    required this.currentOffset,
    required this.onOffsetChanged,
    required this.externalTargetDate,
    required this.applyTick,
  });

  final int fundId;
  final String fundName;

  final DateTime displayedDate;

  final List<FundRow> dayRows;

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
          height: 200,
          child: Row(
            children: <Widget>[
              Container(
                width: 84,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: const Border(right: BorderSide(color: Color(0x22000000))),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${widget.fundId}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text('ID', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.fundName,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      _FlipDateText(
                        controller: _controller,
                        frontText: _frontText,
                        nextText: _nextText,
                        direction: _flipDirection,
                        leadingIcon: Icons.event,
                      ),

                      const SizedBox(height: 8),

                      Expanded(child: _FundDayRowsView(rows: widget.dayRows)),
                    ],
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

class _FundDayRowsView extends StatelessWidget {
  const _FundDayRowsView({required this.rows});

  final List<FundRow> rows;

  ///
  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'データなし',
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rows.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (BuildContext context, int i) {
        final FundRow r = rows[i];
        final int profit = r.profitYen;

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            return Wrap(
              spacing: 10,
              runSpacing: 4,
              children: <Widget>[
                _MiniPill(label: '投資', value: formatYen(r.investedYen)),
                _MiniPill(label: '評価', value: formatYen(r.valuationYen)),
                _MiniPill(label: '損益', value: formatYen(profit)),
              ],
            );
          },
        );
      },
    );
  }
}

//////////////////////////////////////////////////////////

class _MiniPill extends StatelessWidget {
  const _MiniPill({required this.label, required this.value});

  final String label;
  final String value;

  ///
  @override
  Widget build(BuildContext context) {
    final Color bg = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 170),
            child: Text(value, style: const TextStyle(fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
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
      height: 118,
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
              SizedBox(height: 10),
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
