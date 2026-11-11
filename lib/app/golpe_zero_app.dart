import 'package:flutter/material.dart';

import '../screens/analyzer_screen.dart';
import '../screens/home_screen.dart';
import '../screens/library_screen.dart';
import '../screens/prevention_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/simulator_screen.dart';
import '../theme/app_theme.dart';

class GolpeZeroApp extends StatelessWidget {
  const GolpeZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GolpeZero',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _destinations = <({String label, IconData icon})>[
    (label: 'Início', icon: Icons.home_rounded),
    (label: 'Analisador', icon: Icons.shield_outlined),
    (label: 'Quiz', icon: Icons.quiz_outlined),
    (label: 'Simulador', icon: Icons.forum_outlined),
    (label: 'Biblioteca', icon: Icons.menu_book_outlined),
    (label: 'Prevenção', icon: Icons.health_and_safety_outlined),
  ];

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 850;
        final screens = <Widget>[
          HomeScreen(onOpen: _select),
          const AnalyzerScreen(),
          const QuizScreen(),
          const SimulatorScreen(),
          const LibraryScreen(),
          const PreventionScreen(),
        ];
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _AppHeader(
                  wide: wide,
                  onHome: () => _select(0),
                  selectedLabel: _destinations[_selectedIndex].label,
                ),
                Expanded(
                  child: Row(
                    children: [
                      if (wide)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 8, 20),
                          child: NavigationRail(
                            selectedIndex: _selectedIndex,
                            onDestinationSelected: _select,
                            labelType: NavigationRailLabelType.all,
                            backgroundColor: Colors.transparent,
                            destinations: [
                              for (final destination in _destinations)
                                NavigationRailDestination(
                                  icon: Icon(destination.icon),
                                  label: Text(destination.label),
                                ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: screens,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _select,
                  destinations: [
                    for (final destination in _destinations)
                      NavigationDestination(
                        icon: Icon(destination.icon),
                        label: destination.label,
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader({
    required this.wide,
    required this.onHome,
    required this.selectedLabel,
  });

  final bool wide;
  final VoidCallback onHome;
  final String selectedLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom:
              BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'GolpeZero, voltar ao início',
            child: InkWell(
              onTap: onHome,
              borderRadius: BorderRadius.circular(14),
              child: const Row(
                children: [
                  _BrandMark(),
                  SizedBox(width: 11),
                  Text(
                    'GolpeZero',
                    style: TextStyle(
                      color: AppTheme.ink,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (wide)
            Text(
              'Educação digital para se proteger melhor',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.muted,
                  ),
            )
          else
            Text(
              selectedLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.muted,
                  ),
            ),
          const SizedBox(width: 12),
          const Icon(Icons.lock_outline_rounded,
              size: 18, color: AppTheme.teal),
          if (wide) ...[
            const SizedBox(width: 6),
            Text(
              'Seus dados ficam no dispositivo',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.muted,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.blue, AppTheme.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Icon(Icons.shield_rounded, color: Colors.white, size: 23),
    );
  }
}
