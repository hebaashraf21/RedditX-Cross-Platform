import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:provider/provider.dart';
import 'package:reddit/controllers/community_controller.dart';
import 'package:reddit/methods/show_profile_dialog.dart';
import 'package:reddit/views/widgets/pop_up_menu_button.dart';
import 'package:reddit/views/widgets/post_bottom_widget.dart';

import '../../models/post_model.dart';

class PostCardWidget extends StatelessWidget {
  final String postType;
  final int index;
  const PostCardWidget(
      {required this.index, required this.postType, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showeProfileDialog(context, index);
                        },
                        child: Text(
                          "u/${postsList[index].username}",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),
                      Consumer<CommunityProvider>(
                        builder: (context, value, child) => Text(
                          "  ${value.calculateAge(postsList[index].createdAt)}",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),
                      if (postType == 'image')
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "  · i.redd.it",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 15),
                          ),
                        ),
                      if (postType == "text") const Spacer(),
                      PopUpMenu(index: index),
                    ],
                  ),
                  if (postType == "text")
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        postsList[index].text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  else
                    FloatColumn(
                      children: [
                        Floatable(
                            float: FCFloat.end,
                            padding: (postType == 'image')
                                ? const EdgeInsets.only(left: 8, right: 8)
                                : const EdgeInsets.only(left: 0),
                            child: (postType == 'link')
                                ? SizedBox(
                                    height: 90,
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: LinkPreviewGenerator(
                                        link: postsList[index].attachments[0],
                                        linkPreviewStyle:
                                            LinkPreviewStyle.small,
                                        bodyMaxLines: 1,
                                        bodyTextOverflow: TextOverflow.ellipsis,
                                        showBody: false,
                                      ),
                                    ),
                                  )
                                : (postType == 'image')
                                    ? Container(
                                        height: 90,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    postsList[index]
                                                        .attachments[0]))),
                                      )
                                    : const SizedBox(height: 20)),
                        WrappableText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 9,
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            text: TextSpan(text: postsList[index].title))
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: PostBottomWidget(
                index: index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
