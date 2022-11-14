import 'package:flutter/material.dart';
import 'package:rest_api2/services/remote_services.dart';

import '../models/Post.dart';


class HomeScean extends StatefulWidget {
  const HomeScean({Key? key}) : super(key: key);

  @override
  State<HomeScean> createState() => _HomeSceanState();
}

class _HomeSceanState extends State<HomeScean> {

  List<Post>?posts;
  bool isloaded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Api"),
      ),
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context,index){
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(posts![index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),

                      ),
                      Text(posts![index].body ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,

                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        },),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void getData() async{
posts=await RemoteService().getPosts();

if(posts!=null){
setState(() {
  isloaded=true;
});

}
  }
}
