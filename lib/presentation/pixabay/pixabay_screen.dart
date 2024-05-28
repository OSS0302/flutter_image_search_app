import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixabay image app'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                  hintText: '이미지를 검색하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final result = await pixabayViewModel
                          .fetchImaage(textEditingController.text);
                      if (result == false) {
                        const snackBar =
                            SnackBar(content: Text('인터넷이 연결 안되거나 오류'));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              state.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems = state.pixabayItem[index];
                          return PixabayWidget(pixabayItem: pixabayItems);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
