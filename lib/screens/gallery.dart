import 'package:api_bloc/bloc/image/image_bloc.dart';
import 'package:api_bloc/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gallery extends StatefulWidget {
  final String code;
  final String name;
  const Gallery({super.key, required this.code,required this. name});

  @override
  State<Gallery> createState() => _GalleryState();
}
class _GalleryState extends State<Gallery> {
  late ImageBloc imageBloc;
  bool isLoading = false;

  List<Data> apiData = [];

  @override
  void initState() {
    super.initState();
    imageBloc = ImageBloc();
    imageBloc.add(GetImageEvent(widget.code));
  }

  _listenerBloc(BuildContext context, dynamic state) {
    if (state is GetImageLoadingState) {
      isLoading = true;
    } else if (state is GetImageErrorState) {
     isLoading = false;
      print(state.err);
    } else if (state is GetImageLoadedState) { 
        apiData = state.data;
        isLoading = false;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade600),
        title: Text("${widget.name}  Photos",style: TextStyle(color: Colors.grey.shade600),),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => imageBloc,
        child: BlocConsumer<ImageBloc, ImageState>(
          listener: _listenerBloc,
          builder: (context, state) {
            if (state is GetImageErrorState) {
              return Center(child: Text("Error: ${state.err}"));
            }
            return buildUI();
          },
        ),
      ),
    );
  }

  Widget buildUI() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: DefaultTabController(
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(
            //   child: Text(
            //     widget.name,
            //     style: TextStyle(
            //       color:Colors.grey.shade700,
            //       fontSize: 20,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // Divider(color: Colors.grey.shade500, thickness: 0.3),
            TabBar(
              isScrollable: true,
              labelColor: Colors.grey.shade700,
              unselectedLabelColor: Colors.grey.shade400,
              indicatorColor: Colors.grey.shade600,
              dividerColor: Colors.grey.shade500,
               textScaler: TextScaler.linear(1.1),
              tabs: [
                Tab(text: "Profile"),
                Tab(text: "Front"),
                Tab(text: "Side"),
                Tab(text: "Interior"),
                Tab(text: "Other"),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10),
                child: TabBarView(
                  children: [
                    buildImageList(imagesTag("profile")),
                    buildImageList(imagesTag("front")),
                    buildImageList(imagesTag("side")),
                    buildImageList(imagesTag("interior")),
                    buildImageList(imagesTag("others")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Data> imagesTag(String tag) {
    return apiData
        .where(
          (image) =>
              image.tag?.toLowerCase() == tag.toLowerCase()
        )
        .toList();
  }
  Widget buildImageList(List<Data> images) {
    if (images.isEmpty) {
      return Center(child: Text("No Images ❗",style: TextStyle(color: Colors.blue.shade400),));
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      separatorBuilder: (BuildContext, int) => SizedBox(width: 10),
      itemBuilder: (context, index) {
        final imgSlug = images[index].imageUrlSlug;
        final imgUrl =
            (imgSlug != null && imgSlug.isNotEmpty)
                ? "http://dms.eics.in/download/$imgSlug"
                : "https://demofree.sirv.com/nope-not-here.jpg";

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imgUrl,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
