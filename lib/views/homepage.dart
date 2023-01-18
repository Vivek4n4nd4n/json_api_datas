

import 'package:flutter/material.dart';
import 'package:json_api_datas/model/services/post.dart';
import 'package:json_api_datas/model/services/remote_services.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>?posts;
 var isloaded =false;

 @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    posts =await RemoteServices().getPosts();
    if(posts!= null){
      setState(() {
        isloaded=true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api datas'),),
      body: Visibility(
        visible: isloaded,
           replacement: const Center(child: CircularProgressIndicator(),),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height:320,
              decoration: BoxDecoration(border: Border.all(width: 5,color: Colors.green)),
                child: Column(children: [
                 
                  
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(posts![index].albumId.toString(),style: TextStyle(fontSize: 25)),
                        SizedBox(width: 30,),
                         Text(posts![index].id.toString(),style: TextStyle(fontSize: 25),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(posts![index].title,maxLines: 2,
                    overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 25),),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(height: 100,width: 100,
                          child: Image.network(posts![index].url,fit: BoxFit.cover,)),
                      ),
                
                
                 SizedBox(width: 30,),
                  Container(
                    height: 100,width: 100,
                    child: Image.network(posts![index].thumbnailUrl,fit: BoxFit.cover,))],),
                 ],
                  ),
                  ),
            );
          }
        ),
      ) );
  }
}