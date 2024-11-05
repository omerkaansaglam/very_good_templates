import 'package:{{project_name.snakeCase()}}/core/managers/locale_manager/locale_keys.g.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/locale_manager/locale_manager.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/theme_manager/theme_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:{{project_name.snakeCase()}}/ui/views/main/view_model/main_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MainView extends ConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datas = ref.watch(mainViewModelProvider);
    final fetchDatas = ref.watch(fetchDatasFutureProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.language,
          ),
          onPressed: () => ref.read(localeProvider).toggleLocale(),
        ),
        title: Text(LocaleKeys.appName.tr()),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.brightness_4,
            ),
            onPressed: () =>
                ref.read(themeManagerProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: fetchDatas.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async => await ref.refresh(fetchDatasFutureProvider),
            child: ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final data = datas[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    selected: data.completed,
                    title: Text(data.title ?? ''),
                    subtitle: Text('${data.userId}'),
                    onTap: () {
                      ref.read(mainViewModelProvider.notifier).toggleData(data);
                    },
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
