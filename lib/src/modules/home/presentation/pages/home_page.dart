import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/background_container.dart';
import '../../../../common/widgets/common_appbar.dart';
import '../widgets/home_body.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CommonAppBar(
        context: context,
        title: context.s.common_home,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            splashColor: context.colorTheme.primary.withOpacity(0.5),
            onPressed: () => {},
          ),
        ],
      ),
      body: BackgroundContainer(child: const HomeBody()),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
