
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:setstate/pages/home_page.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});
  static const String id="addPost";

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  bool isLoading = false;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController bodyEditingController = TextEditingController();

  apiPostCreate(Post post)  async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(title: titleEditingController.text, body: bodyEditingController.text,
        userId: 1, id: 1);

    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));

    setState(() {
      if (response != null) {
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post',style: TextStyle(color: Colors.white,fontSize: 20),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Title",style: TextStyle(color: Colors.grey,fontSize: 20),),
                  const SizedBox(height: 10,),
                  // #title
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: TextField(
                      maxLines: 50,
                      controller: titleEditingController,
                      style: const TextStyle(color:Colors.white,fontSize: 20),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text("Content",style: TextStyle(color: Colors.grey,fontSize: 20),),
                  const SizedBox(height: 10,),
                  // #content
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: TextField(
                      controller: bodyEditingController,
                      style: const TextStyle(color:Colors.white,fontSize: 18),
                      maxLines: 300,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){apiPostCreate(post as Post);},
                    color: Colors.blue,
                    minWidth: double.infinity,
                    height: 45,
                    child: const Text("Add",style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ],
              ),
            ),
          ),

          isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
