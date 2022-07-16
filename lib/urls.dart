import 'dart:convert';

import 'package:http/http.dart' as http;

// String getPost = "http://192.168.1.20/wowql/hem/post";
// String createPost = "http://192.168.1.20/wowql/hem/post/create";
// String updatePost = "http://192.168.1.20/wowql/hem/id/update";
// String deletePost = "http://192.168.1.20/wowql/hem/id/delete";

class BlogPosts {
  // get data from data base
  Future<List> get_post() async {
    try {
      http.Response response =
          await http.get(Uri.parse("http://10.0.2.2:8000/hem/post"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // delete data into database
  Future<List> delete_post(int id) async {
    try {
      http.Response response = await http
          .delete(Uri.parse("http://10.0.2.2:8000/hem/post/${id}/delete/"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // insert data into database
  Future<List> add_post(String title, String content) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://10.0.2.2:8000/hem/post/create"),
          body: {'title': title, 'content': content});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // insert data into database
  Future<List> update_post(int id, String title, String content) async {
    try {
      print(title);
      print(id);
      print(content);
      http.Response response = await http.put(
          Uri.parse("http://10.0.2.2:8000/hem/post/${id}/update/"),
          body: {"title": title, "content": content});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
