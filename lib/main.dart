import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
Future<Album> fetchAlbum() async{
  final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
      if(response.statusCode==200) {
        return Album.fromJson(
            jsonDecode(response.body));
      }
      else{
        throw Exception('failed to load Album');
      }
}
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
});
  factory Album.fromJson(Map<String,dynamic>json){
    return Album(userId: json['userId'],
    id: json['id'],
    title: json['title'],
    );
  }
}
void main()=>runApp(Myapp());
class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  late Future<Album> futureAlbum;
  @override
  void initState(){
    super.initState();
    futureAlbum=fetchAlbum();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fetch data example',
        theme:ThemeData(
          primarySwatch: Colors.blue,

        ),
      home:Scaffold(
        appBar: AppBar(title: const Text('fetch data example'),),
        body: Center(
          child:FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data!.title);
              }
              else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();

            }
          ) ,
        ),
      ),
    );
  }
}


