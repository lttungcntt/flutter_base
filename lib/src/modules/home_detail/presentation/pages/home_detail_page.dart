import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/common_appbar.dart';
import '../../../home/domain/entities/home.dart';
import '../widgets/home_detail_body.dart';

@RoutePage()
class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({super.key, required this.data});

  final IHome data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeDetailBody(),
      appBar: CommonAppBar(
        context: context,
        title: data.name,
        leading: IconButton(
          splashColor: context.colorTheme.primary.withOpacity(0.8),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }
}
