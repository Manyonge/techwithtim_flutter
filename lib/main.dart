import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arthur App ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class Post{
  String author;
  String body;
  int likes = 0;
  bool isLiked= false;

  Post(this.body, this.author);

void likePost(){
  isLiked = !isLiked;
  if(isLiked){
    likes +=1;
    return;
  }
  likes -=1;
}

}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  List<Post> posts = [];
@override
void dispose(){
  super.dispose();
  controller.dispose();
}
void addPost(txt){
  setState(() {
    posts.add(Post(txt, 'Arthur'));
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arthur App'),
      ),
      body: Column(children: <Widget>[

Expanded(child: PostList(posts)),
Expanded(child: TextInputWidget(addPost)),


      ],)
    );
  }
}




class TextInputWidget extends StatefulWidget {
  final Function(String) callback;
   TextInputWidget(this.callback);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
final controller = TextEditingController();

@override
void dispose(){
  super.dispose();
  controller.dispose();
}

  void onClick(){
    widget.callback(controller.text);
    controller.clear();
  }
    

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      
      TextField(controller: controller, decoration: InputDecoration(prefixIcon: const Icon(Icons.message), suffixIcon: IconButton(onPressed: ()=>onClick(), icon: const Icon(Icons.send), splashColor: Colors.red,), labelText: "Type a message")
      )  
    ],);
  }
}

class PostList extends StatefulWidget {
  final List<Post> posts;
  PostList(this.posts);
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder:(context, index) {
        Post post = widget.posts[index];
        return Row(children: [
          Text(post.likes.toString()),
          Text(post.body),
        ],);
      },
    );
  }
}