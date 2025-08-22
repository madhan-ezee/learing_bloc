import 'package:api_bloc/bloc/gallery/gallary_bloc.dart';
import 'package:api_bloc/models/gallery_model.dart';
import 'package:api_bloc/screens/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusGalleryPage extends StatefulWidget {
  const BusGalleryPage({super.key});

  @override
  State<BusGalleryPage> createState() => _BusGalleryPageState();
}

class _BusGalleryPageState extends State<BusGalleryPage> {
  GallaryBloc gallaryBloc = GallaryBloc();
  bool isLoading = false;

  @override
  void initState() {
    gallaryBloc.add(GetGalleryEvent());
    super.initState();
  }

  List<GetGalleries> apiData = [];

  _listenerBloc(context, state) {
    if (state is GetGalleryLoadingState) {
      isLoading = true;
    } else if (state is GetGalleryErrorState) {
      isLoading = false;
      print(state.err);
    } else if (state is GetGalleryLoadedState) {
      print("GetGalleryLoadedState");
      print(state.data);
      apiData = state.data;
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Bus Gallery",
            style: TextStyle(color: Colors.grey.shade600,fontSize: 24, ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => gallaryBloc,
        child: BlocConsumer(
          bloc: gallaryBloc,
          listener: (context, state) {
            _listenerBloc(context, state);
          },
          builder: (context, state) {
            if (state is GetGalleryErrorState) {
              return Column(children: [Text(state.err)]);
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
    final filteredData =
        apiData
            .where(
              (item) =>
                  (item.code != null && item.code!.isNotEmpty) &&
                  (item.name != null && item.name!.isNotEmpty),
            )
            .toList();
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        final images = item.imageDetails;
        final firstImageSlug =
            (images != null && images.isNotEmpty)
                ? images[0].imageUrlSlug
                : null;
        final firstImageUrl =
            (firstImageSlug != null && firstImageSlug.isNotEmpty)
                ? "http://dms.eics.in/download/$firstImageSlug"
                : "https://demofree.sirv.com/nope-not-here.jpg";

        final imageCount = images?.length ?? 0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Gallery(code:item.code!,name:item.name!)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade50,
                  // blurRadius: 0.5,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    firstImageUrl,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    item.name!,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "$imageCount Item",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
