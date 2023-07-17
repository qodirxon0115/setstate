
import 'package:flutter_test/flutter_test.dart';
import 'package:setstate/model/post_model.dart';
import 'package:setstate/services/http_service.dart';

void main(){
  test("Posts is not null", () async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response!);
    expect(posts, isNotNull);
  });

  test("Posts is greater than zero", () async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response!);
    expect(posts.length,greaterThan(0));
  });

  test("Posts is exactly 100", () async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response!);
    expect(posts.length,equals(100));
  });
}