import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/extensions/build_context_dialog.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/background_container.dart';
import '../../../../common/widgets/shimmer_loading_cart.dart';
import '../../application/cubit/home_cubit.dart';
import 'home_card.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      homeProvider,
      (_, nov) {
        if (nov.status.isError) {
          context.showError(nov.error?.message ?? 'Error', onPressed: () {
            ref.read(homeProvider.bloc).get();
          });
        }
      },
    );

    final state = ref.read(homeProvider.select((state) => state));

    return BackgroundContainer(
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeProvider.bloc).get(isRefresh: true);
        },
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: state.status.isLoading ? 10 : state.homes.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 12.w, top: 12.w),
            child: Divider(
              color: context.colorTheme.primaryText.withOpacity(0.4),
              height: 1.5,
            ),
          ),
          padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: context.mediaQuery.padding.bottom + 32,
                  top: 16)
              .w,
          itemBuilder: (context, index) => state.status.isLoading
              ? const ShimmerLoadingCard(child: HomeCard())
              : HomeCard(home: state.homes[index]),
        ),
      ),
    );
  }
}
