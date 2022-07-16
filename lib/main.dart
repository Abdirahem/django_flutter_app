import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'urls.dart';

void main() {
  runApp(MaterialApp(
    home: MyBlog(),
  ));
}

class MyBlog extends StatefulWidget {
  const MyBlog({Key? key}) : super(key: key);

  @override
  State<MyBlog> createState() => _MyBlogState();
}

class _MyBlogState extends State<MyBlog> {
  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();
  BlogPosts posts = BlogPosts();

  @override
  void initState() {
    posts.get_post();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            AddForm(context);
          },
        )),
        body: SafeArea(
          child: FutureBuilder<List>(
            future: posts.get_post(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return Container(
                  padding: EdgeInsets.all(10),
                  height: double.infinity,
                  width: double.infinity,
                  child: Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    int pid = snapshot.data![index]["id"];
                                    setState(() {
                                      posts.delete_post(pid);
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    int id = snapshot.data![index]['id'];
                                    String title =
                                        snapshot.data![index]['title'];
                                    String content =
                                        snapshot.data![index]['content'];
                                    UpdataForm(context, id, title, content);
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Colors.green.shade700,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index]['title'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data![index]['content']),
                                ),
                              ),
                            );
                          }))),
                );
              } else {
                return Container(
                  child: Center(child: Text("Data not Found")),
                );
              }
            },
          ),
        ));
  }

  Future<dynamic> UpdataForm(
      BuildContext context, int id, String title, content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    controller: title_controller,
                    decoration: InputDecoration(
                      hintText: title,
                    ),
                  ),
                  Spacer(flex: 1),
                  TextField(
                    controller: content_controller,
                    decoration: InputDecoration(
                      hintText: content,
                    ),
                  ),
                  Spacer(flex: 1),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        posts.update_post(
                            id, title_controller.text, content_controller.text);
                        title_controller.clear();
                        content_controller.clear();
                      });
                    },
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> AddForm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    controller: title_controller,
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  Spacer(flex: 1),
                  TextField(
                    controller: content_controller,
                    decoration: InputDecoration(
                      hintText: 'Content',
                    ),
                  ),
                  Spacer(flex: 1),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        posts.add_post(
                            title_controller.text, content_controller.text);
                        title_controller.clear();
                        content_controller.clear();
                      });
                    },
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
          );
        });
  }
}
