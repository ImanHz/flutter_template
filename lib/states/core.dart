import 'package:hooks_riverpod/hooks_riverpod.dart';

// these are some wrappers to avoid boilerplate code.
// three ready-to-use notifiers are added here, for
// boolean values, generic lists and maps.
// other types could be added on demand.
// you can add other methods as well.
// theme.dart and list_sample.dart for some examples

/*  Boolean notifier  */
class BooleanNotifier extends StateNotifier<bool> {
  BooleanNotifier(this.initialState) : super(initialState);

  final bool initialState;

  void set() {
    state = true;
  }

  void reset() {
    state = false;
  }

  void toggle() {
    state = state ? false : true;
  }

  void update(bool st) {
    state = st;
  }
}

// this function returns a provider for boolean notifier
StateNotifierProvider<BooleanNotifier, bool> getBoolStateNotifier(
    {bool initialValue = false}) {
  return StateNotifierProvider<BooleanNotifier, bool>(
      (ref) => BooleanNotifier(initialValue));
}

/*  List notifier  */
class ListNotifier<T> extends StateNotifier<List<T>> {
  ListNotifier({this.initialState}) : super(initialState ?? []);

  // pay attention to state immutability
  final List<T>? initialState;
  void add(T item) {
    state = [...state, item];
  }

  void addAll(List<T> items) {
    state = [...state, ...items];
  }

  void removeAt(int index) {
    var temp = state;
    temp.removeAt(index);
    state = [...temp];
  }

  void flush() {
    state = [];
  }
}

StateNotifierProvider<ListNotifier<T>, List<T>> getListStateNotifier<T>(
    {List<T>? initialState}) {
  return StateNotifierProvider<ListNotifier<T>, List<T>>(
      (ref) => ListNotifier<T>(initialState: initialState));
}

/*  Map notifier  */
class MapNotifier<K, V> extends StateNotifier<Map<K, V>> {
  MapNotifier({this.initialState}) : super(initialState ?? {});

  final Map<K, V>? initialState;

  add(K key, V value) {
    state = {...state, key: value};
  }

  remove(K key) {
    final temp = state;
    temp.remove(key);
    state = {...temp};
  }

  flush() {
    state = {};
  }
}

StateNotifierProvider<MapNotifier<K, V>, Map<K, V>> getMapStateNotifier<K, V>(
    {Map<K, V>? initialState}) {
  return StateNotifierProvider<MapNotifier<K, V>, Map<K, V>>(
      (ref) => MapNotifier<K, V>(initialState: initialState));
}

/* Generic scalar notifier */

// later all notifiers may be moved here
class GenericNotifier<T> extends StateNotifier<T> {
  GenericNotifier({required this.ref, required this.initialState})
      : super(initialState);

  final T initialState;
  final StateNotifierProviderRef<GenericNotifier<T>, T> ref;

  void set(T newValue) {
    state = newValue;
  }
}

StateNotifierProvider<GenericNotifier<T>, T> getGenericNotifier<T>(
    T initialState) {
  return StateNotifierProvider(
      (ref) => GenericNotifier(ref: ref, initialState: initialState));
}
