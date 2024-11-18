import 'package:bookinghotel/model/app_constants.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:bookinghotel/view/hostScreens/create_posting_screen.dart';
import 'package:bookinghotel/view/widgets/posting_list_tile_button.dart';
import 'package:bookinghotel/view/widgets/posting_list_tile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostingsScreen extends StatefulWidget {
  const MyPostingsScreen({super.key});

  @override
  State<MyPostingsScreen> createState() => _MyPostingsScreenState();
}

class _MyPostingsScreenState extends State<MyPostingsScreen> {
  List<PostingModel> userPostings = [];

  @override
  void initState() {
    super.initState();
    _filterUserPostings();
  }

  void _filterUserPostings() {
    // Giả sử currentUserID là một thuộc tính của AppConstants.currentUser
    final currentUserID = AppConstants.currentUser.id;
    userPostings = AppConstants.currentUser.myPostings!
        .where((posting) => posting.host!.id == currentUserID)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView.builder(
        itemCount: userPostings.length + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: InkResponse(
              onTap: () {
                Get.to(CreatePostingScreen(
                  posting: (index == userPostings.length)
                      ? null
                      : userPostings[index],
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1.2,
                  ),
                ),
                child: (index == userPostings.length)
                    ? const PostingListTileButton()
                    : PostingListTileUI(
                        posting: userPostings[index],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
