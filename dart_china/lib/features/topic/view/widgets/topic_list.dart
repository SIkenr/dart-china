part of 'widgets.dart';

Widget buildSliverTopicList(BuildContext context) {
  return BlocBuilder<TopicCubit, TopicState>(builder: (_, state) {
    if (state is TopicSuccess) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            var topic = state.topics[index];
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F6FA),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFDFDFD),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TopicCard(
                title: topic.title,
                body: topic.excerpt ?? topic.title,
                pin: topic.pinnedGlobally,
                viewCount: topic.views,
                replyCount: topic.postsCount,
                likeCount: topic.likeCount,
                slug: topic.categorySlug ?? '',
              ),
            );
          },
          childCount: state.topics.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  });
}

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key? key,
    required this.title,
    required this.body,
    required this.slug,
    this.pin = false,
    this.viewCount = 0,
    this.replyCount = 0,
    this.likeCount = 0,
  }) : super(key: key);

  final String title;
  final String body;
  final String slug;
  final bool pin;
  final int viewCount;
  final int replyCount;
  final int likeCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 10,
      ),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TopicCardHead(
            title: title,
            pin: pin,
          ),
          TopicBody(content: body),
          SizedBox(height: 8),
          TopicStatus(
            slug: slug,
            view: viewCount,
            reply: replyCount,
            like: likeCount,
          ),
        ],
      ),
    );
  }
}

class TopicStatus extends StatelessWidget {
  const TopicStatus({
    Key? key,
    this.slug = '',
    this.view = 0,
    this.reply = 0,
    this.like = 0,
  }) : super(key: key);

  final String slug;
  final int view;
  final int reply;
  final int like;

  Text buildType() {
    var type = '其他';
    switch (slug) {
      case 'share':
        type = '分享';
        break;
      case 'question':
        type = '问答';

        break;
      case 'meta':
        type = '站务';

        break;
    }

    return Text(
      type,
      style: TextStyle(
        fontSize: 11,
        color: Color(0xFFB0B1BA),
        height: 1,
      ),
    );
  }

  Color buildColor() {
    var color = Color(0xFFB0B1BA);
    switch (slug) {
      case 'share':
        color = Color(0xFF40a37e);
        break;
      case 'question':
        color = Color(0xFFd9a01c);

        break;
      case 'meta':
        color = Color(0xFFa19b8f);

        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: buildColor(),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 5),
              buildType(),
              SizedBox(width: 50),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$view',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$reply',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$like',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopicCardHead extends StatelessWidget {
  const TopicCardHead({
    Key? key,
    required this.title,
    this.pin = false,
  }) : super(key: key);

  final String title;
  final bool pin;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                'assets/icon/logo_dart_ios.png',
                fit: BoxFit.fitWidth,
                width: 35,
                height: 35,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    'Janu Ptura • 1小时前',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.push_pin_outlined,
                color: pin ? Color(0xFFB0B1BA) : Colors.transparent,
                size: 15,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class TopicBody extends StatelessWidget {
  const TopicBody({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        content,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color(0xFF8E8E9F),
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}