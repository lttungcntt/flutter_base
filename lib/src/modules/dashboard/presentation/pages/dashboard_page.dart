import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../main.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/logger.dart';
import '../../../app/app_router.dart';

enum NavigationItem { home, about, setting }

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      resizeToAvoidBottomInset: false,
      routes: [
        const HomeRoute(),
        const AboutRoute(),
        const SettingsRoute(),
      ],
      homeIndex: NavigationItem.home.index,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      transitionBuilder: (_, child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      bottomNavigationBuilder: (_, tabsRouter) {
        return _BottomAppBar(tabsRouter: tabsRouter);
      },
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final mode = BottomNavigationModeRegion.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        bottom: mode == 2 ? 8.h : 0,
      ),
      decoration: BoxDecoration(
        color: context.colorTheme.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorTheme.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationButton(
              value: NavigationItem.home,
              isSelected: tabsRouter.activeIndex == NavigationItem.home.index),
          _NavigationButton(
              value: NavigationItem.about,
              isSelected: tabsRouter.activeIndex == NavigationItem.about.index),
          _NavigationButton(
              value: NavigationItem.setting,
              isSelected:
                  tabsRouter.activeIndex == NavigationItem.setting.index),
        ],
      ),
    );
  }
}

class _NavigationButton extends ConsumerWidget {
  const _NavigationButton({
    required this.value,
    required this.isSelected,
  });

  final NavigationItem value;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabRouter = AutoTabsRouter.of(context);
    return Flexible(
      child: SizedBox(
        width: 76.w,
        child: IconButton(
          onPressed: () {
            logger.d(value);
            tabRouter.setActiveIndex(value.index);
          },
          padding: EdgeInsets.only(top: 8.h),
          iconSize: 24.w,
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSelected ? value.iconSelected : value.icon,
              3.verticalSpace,
              _getTabText(context, isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTabText(BuildContext context, bool isSelected) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.s.getNavTitle(value),
            textAlign: TextAlign.center,
            style: context.textTheme.semiBold.copyWith(
              fontSize: 12.sp,
              color: isSelected
                  ? context.colorTheme.primary
                  : context.colorTheme.textUnselected,
            ),
          ),
          8.verticalSpace,
          Container(
            width: 34.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorTheme.primary
                  : Colors.transparent, // Specify the container's fill color
              borderRadius: BorderRadius.circular(2.r), // Apply a border radius
            ),
          ),
          2.verticalSpace,
        ],
      );
}

extension NavigationItemX on NavigationItem {
  Widget get icon => switch (this) {
        NavigationItem.home => Icon(Icons.home_outlined, size: 24.w),
        NavigationItem.about => Icon(Icons.info_outline, size: 24.w),
        NavigationItem.setting => Icon(Icons.settings_outlined, size: 24.w),
      };

  Widget get iconSelected => switch (this) {
        NavigationItem.home => Icon(Icons.home_outlined, size: 24.w),
        NavigationItem.about => Icon(Icons.info_outline, size: 24.w),
        NavigationItem.setting => Icon(Icons.settings_outlined, size: 24.w),
      };
}

extension DashboardBodyS on S {
  String getNavTitle(NavigationItem item) => switch (item) {
        NavigationItem.home => common_home,
        NavigationItem.about => common_about,
        NavigationItem.setting => common_settings,
      };
}
