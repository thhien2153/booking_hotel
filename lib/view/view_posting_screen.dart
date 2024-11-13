import 'package:bookinghotel/model/app_constants.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:bookinghotel/view/guestScreens/book_listing_screen.dart';
import 'package:bookinghotel/view/widgets/posting_info_tile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPostingScreen extends StatefulWidget {
  PostingModel? posting;
  ViewPostingScreen({super.key, this.posting});

  @override
  State<ViewPostingScreen> createState() => _ViewPostingScreenState();
}

class _ViewPostingScreenState extends State<ViewPostingScreen> {
  PostingModel? posting;

  getRequiredInfo() async {
    await posting!.getAllImagesFromStorage();

    await posting!.getHostFromFirestore();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posting = widget.posting;

    getRequiredInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
        title: Text('Posting Information'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: () {
                AppConstants.currentUser.addSavePosting(posting!);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Listing Image
            AspectRatio(
              aspectRatio: 3 / 2,
              child: PageView.builder(
                  itemCount: posting!.displayImages!.length,
                  itemBuilder: (context, index) {
                    MemoryImage currentImage = posting!.displayImages![index];
                    return Image(
                      image: currentImage,
                      fit: BoxFit.fill,
                    );
                  }),
            ),

            //Posting Name btn //book now btn
            // description - profile pic
            //apartments - beds - bathrooms
            //amnities
            //the location
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Posting Name and price  //book now btn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Sử dụng Expanded để phần văn bản có đủ không gian
                      Expanded(
                        child: Text(
                          posting!.name!.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Book now và giá
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Get.to(BookListingScreen(
                                    posting: posting,
                                    hostID: posting!.host!.id!));
                              },
                              child: const Text(
                                'Book now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${posting!.price} /night',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // description - profile pic and name
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.75,
                          child: Text(
                            posting!.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 5,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width / 12.5,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundImage: posting!.host!.displayImage,
                                  radius:
                                      MediaQuery.of(context).size.width / 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                posting!.host!.getFullNameOfUser(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //apartments - beds - bathrooms
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PostingInfoTileUI(
                          iconData: Icons.home,
                          category: 'Apartment',
                          categoryInfo: '${posting!.getGuestsNumber()} guests',
                        ),
                        PostingInfoTileUI(
                          iconData: Icons.hotel,
                          category: 'Beds',
                          categoryInfo: posting!.getBedroomText(),
                        ),
                        PostingInfoTileUI(
                          iconData: Icons.wc,
                          category: 'Bathrooms',
                          categoryInfo: posting!.getBathroomText(),
                        ),
                      ],
                    ),
                  ),

                  //amnities
                  const Text(
                    'Amenities: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 25),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 3.6,
                      children: List.generate(
                        posting!.amenities!.length,
                        (index) {
                          String currentAmenity = posting!.amenities![index];
                          return Chip(
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                currentAmenity,
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.white10,
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      posting!.getFullAddress(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
