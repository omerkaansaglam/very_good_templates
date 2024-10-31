import 'package:faladdin_flutterapp/ui/views/main/service/main_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/data.dart';

final mainViewModelProvider =
    AutoDisposeNotifierProvider<_MainViewModel, List<Data>>(_MainViewModel.new);

class _MainViewModel extends AutoDisposeNotifier<List<Data>> {
  @override
  List<Data> build() => [];

  void setDatas(List<Data> datas) {
    state = datas;
  }

  void addData(Data data) {
    state = [...state, data];
  }

  void toggleData(Data data) {
    state = state.map((e) {
      if (e.id == data.id) {
        return e.copyWith(completed: !e.completed);
      }
      return e;
    }).toList();
  }

  void removeData(Data data) {
    state = state.where((e) => e.id != data.id).toList();
    ref.invalidate(fetchDatasFutureProvider);
  }
}

final fetchDatasFutureProvider = FutureProvider.autoDispose<List<Data>>(
  (ref) async {
    final datas = await ref.read(mainServiceProvider).fetchDatas();
    datas.map(
      success: (value) {
        ref.read(mainViewModelProvider.notifier).setDatas(datas.data);
        return datas.data;
      },
      failure: (value) => throw Exception(value),
    );
    return [];
  },
);
