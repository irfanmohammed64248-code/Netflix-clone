import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopNavigationProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changeTab(int index) {
    state = index;
  }
}

final topNavigationProvider = NotifierProvider<TopNavigationProvider, int>(
  () => TopNavigationProvider(),
);

class BottomNavigationNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changeTab(int index) {
    state = index;
  }
}

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationNotifier, int>(
      () => BottomNavigationNotifier(),
    );
