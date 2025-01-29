import 'package:go_router/go_router.dart';
import 'package:saveit/presentation/main_screen.dart';
import 'package:saveit/presentation/splash_screen.dart';
import 'package:saveit/presentation/record/screens/record_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/record',
        builder: (context, state) => RecordScreen(
          initialTabIndex: state.extra as int? ?? 0,
        ),
      ),
    ],
  );
} 