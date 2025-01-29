import 'package:go_router/go_router.dart';
import 'package:saveit/presentation/main_screen.dart';
import 'package:saveit/presentation/record/screens/record_screen.dart';
import 'package:saveit/presentation/splash_screen.dart';
import 'package:saveit/presentation/record/screens/record_add_screen.dart';

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
        builder: (context, state) => const RecordScreen(),
      ),
      GoRoute(
        path: '/record/add',
        builder: (context, state) => RecordAddScreen(
          initialTabIndex: state.extra as int? ?? 0,
        ),
      ),
    ],
  );
}