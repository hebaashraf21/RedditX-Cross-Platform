import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/search_controller.dart';
import '../../models/search_model.dart';
import 'circular_image_widget.dart';
import 'follow_join_button_in_search_rsults.dart';
import 'username_communityname.dart';

class PeopleSearchResult extends StatelessWidget {
  final PersonInSearch personData;
  //to select which item this widget represents
  final int index;
  const PeopleSearchResult({
    Key? key,
    required this.personData,
    required this.index,
  }) : super(key: key);

  String dateToShow() {
    //calculate the number of days,months and years the person has been in Reddit
    int years = DateTime.now().year - personData.date.year;
    int months = DateTime.now().month - personData.date.month;
    int days = DateTime.now().day - personData.date.day;
    if (years == 1 && months < 0) {
      years = 0;
    }
    if (months < 0) {
      months = (12 - personData.date.month) + DateTime.now().month;
    } else if (months == 1 && days < 0) {
      months = 0;
    }

    if (days < 0) {
      int daysCount = personData.date.month == 2
          ? 28
          : (personData.date.month == 1 ||
                  personData.date.month == 3 ||
                  personData.date.month == 5 ||
                  personData.date.month == 7 ||
                  personData.date.month == 8 ||
                  personData.date.month == 10 ||
                  personData.date.month == 12)
              ? 31
              : 30;
      days = (daysCount - personData.date.day) + DateTime.now().day;
    }
    //format the shown period according to the values of days,months and years
    String shownDate = '';
    if (years != 0) {
      shownDate = '${years}y ${months}m';
    } else if (months != 0) {
      shownDate = '${months}m ${days}d';
    } else {
      shownDate = '${days}d';
    }
    return shownDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                //for free space in the beginning
                const SizedBox(
                  width: 10,
                ),
                //circular image
                CircularImageWidget(img: personData.img),
                //space in the right of the image
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Provider.of<SearchController>(context).isWeb
                        ///////////////////////////////////WEB///////////////////////////////////
                        ? personData.about.isNotEmpty
                            //if about text is not empty
                            ? [
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: FirstRowInWebPeopleInSearch(
                                      personData: personData),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          //show only 100 characters
                                          personData.about.length > 100
                                              ? '${personData.about.substring(0, 100)}...'
                                              : personData.about,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                124, 124, 124, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            //if about text is empty ==> make the name in the middle of the widget vertically
                            : [
                                Expanded(
                                  child: Center(
                                    child: FirstRowInWebPeopleInSearch(
                                        personData: personData),
                                  ),
                                ),
                              ]
                        : ///////////////////////////////////APP///////////////////////////////////
                        [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserOrCommunityNameText(
                                  usernameOrCommunityName: personData.userName,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  personData.karma < 1000
                                      ? '${personData.karma} Karma . ${dateToShow()}'
                                      : personData.karma < 1000000
                                          ? '${personData.karma ~/ 1000},${personData.karma % 1000} Karma . ${dateToShow()}'
                                          : '${personData.karma ~/ 1000000},${personData.karma % 1000000 ~/ 1000},${personData.karma % 1000} Karma . ${dateToShow()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color.fromRGBO(124, 124, 124, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FollowJoinButtonWidget(
                  index: index,
                  isPeopleWidget: true,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          //horizontal line
          const Divider(
            color: Color.fromRGBO(135, 138, 140, 0.2),
          ),
        ],
      ),
    );
  }
}

class FirstRowInWebPeopleInSearch extends StatelessWidget {
  const FirstRowInWebPeopleInSearch({
    super.key,
    required this.personData,
  });

  final PersonInSearch personData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserOrCommunityNameText(
          usernameOrCommunityName: personData.userName,
        ),
        Text(
          personData.karma > 1000000
              ? ' . ${double.parse((personData.karma / 1000000.0).toStringAsFixed(3))}m Karma'
              : personData.karma > 1000
                  ? ' . ${personData.karma / 1000.0}k Karma'
                  : ' . ${personData.karma} Karma',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color.fromRGBO(124, 124, 124, 1),
          ),
        ),
      ],
    );
  }
}
