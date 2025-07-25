import 'package:flutter_todos/core/router/app_routes.dart';
import 'package:flutter_todos/features/todos/ui/screens/home_screen.dart';
import 'package:flutter_todos/features/todos/ui/screens/stats_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: AppRoutes.stats,
      name: 'stats',
      builder: (context, state) => StatsPage(),
    ),
  ],
);
