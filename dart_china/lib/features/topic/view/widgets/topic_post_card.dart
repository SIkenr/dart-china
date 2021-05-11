part of 'widgets.dart';

class TopicPostCard extends StatelessWidget {
  const TopicPostCard({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: kTopicCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TopicPostHeader(
              topicHead: false,
              topic: topic,
              onAvatarPressed: () {},
              onTitlePressed: () {},
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                topic.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ));
  }
}