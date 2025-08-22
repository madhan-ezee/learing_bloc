import 'package:api_bloc/bloc/list_view/list_gallery_bloc.dart';
import 'package:api_bloc/models/gallery_model.dart';
import 'package:api_bloc/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListGallery extends StatefulWidget {
  const ListGallery({super.key});

  @override
  State<ListGallery> createState() => _ListGalleryState();
}

class _ListGalleryState extends State<ListGallery> {
  ListGalleryBloc gallaryBloc = ListGalleryBloc();
  bool isLoading = false;

  @override
  void initState() {
    gallaryBloc.add(GetListGalleryEvent());
    super.initState();
  }

  List<GetGalleries> apiData = [];
  List<Data> apiData2 = [];
  _listenerBloc(context, state) {
    if (state is GetListGalleryLoadingState) {
      isLoading = true;
    } else if (state is GetListGalleryErrorState) {
      isLoading = false;
      print(state.err);
    } else if (state is GetListGalleryLoadedState) {
      print("GetListGalleryLoadedState");
      print(state.data);
      apiData = state.data;
      isLoading = false;

      for (var d in apiData) {

        print(d.code);
        //caLL event 2 WITH CODE


      }
    }

    //EVENT BLOC STATES

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Bus Photo",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      backgroundColor: Colors.blue.shade50,
      body: BlocProvider(
        create: (context) => gallaryBloc,
        child: BlocConsumer(
          bloc: gallaryBloc,
          listener: (context, state) {
            _listenerBloc(context, state);
          },
          builder: (context, state) {
            if (state is GetListGalleryErrorState) {
              return Column(children: [Text(state.err)]);
            }
            return buildUI();
          },
        ),
      ),
    );
  }

  Widget buildUI() {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : 
        ListView.builder(
          itemCount: apiData.length,
          itemBuilder: (context, index) {
            final item = apiData[index];
            final images = item.imageDetails;

            if ((item.code == null || item.code!.isEmpty) &&
                (item.name == null || item.name!.isEmpty)) {
              return SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      color: Colors.blue.shade100,
                      blurRadius: 0.5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: DefaultTabController(
                    length: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (item.code?.isNotEmpty == true) ? item.code! : "",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              (item.name?.isNotEmpty == true) ? item.name! : "",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey.shade500, thickness: 1),

                        TabBar(
                          isScrollable: true,
                          labelColor: Colors.grey.shade700,
                          unselectedLabelColor: Colors.grey.shade400,
                          indicatorColor: Colors.grey.shade600,
                          dividerColor: Color(0x00DA6B1C),
                          textScaler: TextScaler.linear(1.1),
                          tabs: [
                            Tab(text: "ALL"),
                            Tab(text: "Profile"),
                            Tab(text: "Front"),
                            Tab(text: "Side"),
                            Tab(text: "Interior"),
                            Tab(text: "Other"),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 90,
                          child: TabBarView(
                            children: [
                              buildImageList(images),
                              buildImageList(images),
                              buildImageList(images),
                              buildImageList(images),
                              buildImageList(images),
                              buildImageList(images),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }

  List<Data> imagesTag(String tag) {
    return apiData2
        .where((image) => image.tag?.toLowerCase() == tag.toLowerCase())
        .toList();
  }

  Widget buildImageList(List<ImageDetails>? images) {
    if (images == null || images.isEmpty) {
      return Center(child: Text("No Image"));
      // Image.network(
      //   "https://demofree.sirv.com/nope-not-here.jpg",
      // );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      separatorBuilder: (BuildContext, int) => const SizedBox(width: 10),
      itemBuilder: (context, imgIndex) {
        final imgSlug = images[imgIndex].imageUrlSlug;
        final imgUrl =
            (imgSlug != null && imgSlug.isNotEmpty)
                ? "http://dms.eics.in/download/$imgSlug"
                : "https://demofree.sirv.com/nope-not-here.jpg";

        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imgUrl, fit: BoxFit.cover),
        );
      },
    );
  }
}
