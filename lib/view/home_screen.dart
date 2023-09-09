import 'package:flutter/material.dart';
import 'package:flutter_dio_example/extensions/extensions.dart';
import 'package:flutter_dio_example/models/models.dart';
import 'package:flutter_dio_example/network/network.dart';
import 'package:flutter_dio_example/widgets/widgets.dart';

import '../network/dio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isDone  = false;
 // late DioService dioService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: FutureBuilder<List<Post>>(
        future: DioService.instance.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const OutputPanel(showLoading: true);
          } else if (snapshot.hasError) {
            return OutputError(errorMessage: snapshot.error.toString());
          } else if(snapshot.hasData){
            return PostListWidget(snapshot: snapshot,);
          }else{
            return const OutputPanel();
          }
        })
    );
  }
}

class PostListWidget extends StatelessWidget {

  final snapshot;

  const PostListWidget({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(snapshot.data![index].title),
          subtitle: Text(snapshot.data![index].body),
        );
      },
    );
  }
}







