import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class TopicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4162D2),
      ),
      child: SafeArea(
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  // floating: true,
                  delegate: SliverHeader(),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  // floating: true,
                  delegate: SliverCategorySelector(),
                ),
                buildSliverTopicList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
