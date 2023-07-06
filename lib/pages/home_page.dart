import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:setstate/pages/addPost_page.dart';
import 'package:setstate/services/http_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id="home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];
  bool isLoading = false;


  void apiPostList() async{
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    setState(() {
      isLoading = false;
      if(response != null){
        items = Network.parsePostList(response);
      }else{
        items = [];
      }
    });
  }

  void apiPostDelete(Post post) async{
    setState(() {
      isLoading = true;
    });
    var response = Network.DEL(Network.API_DELETE+post.id.toString(), Network.paramsEmpty());
    setState(() {
      if(response != null){
        apiPostList();
      }else{

      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setState"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index){
              return itemOfPost(items[index]);
            },
          ),
          isLoading? const Center(
            child: CircularProgressIndicator(),
          ):const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.pushNamed(context, AddPostPage.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post){
    return Slidable(
      startActionPane: ActionPane(
        motion:const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: (){},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){

            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update",
          )
        ],
      ),
      endActionPane: ActionPane(
        motion:const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: (){},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){
              apiPostDelete(post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title.toUpperCase()),
            const SizedBox(height: 5,),
            Text(post.body),
          ],
        ),
      )
    );
  }

}
