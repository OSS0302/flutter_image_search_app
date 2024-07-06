import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image Search app'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지를 검색 해주세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder(
                  future: ImageRepositoryImpl()
                      .getImageItem(imageSearchController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('(잠시만 기달려주세요)')
                          ],
                        ),
                      );
                    }
                    final imageItem = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                        itemCount: imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = imageItem[index];
                          return ImageWidget(imageItems: imageItems);
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
