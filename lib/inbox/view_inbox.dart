import 'package:flutter/material.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/user.dart';


class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  
  // TextEditingController _sendMessageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              // color: primary,
            )),
        title: Row(
          children: <Widget>[
            
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tyler Nix",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: 3,
                ),
              
              ],
            )
          ],
        ),
      
      ),
      body: getBody(),
     
    );
  }


  Widget getBody() {
    
    return ListView(
      padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
      children: List.generate(messages.length, (index){
        return ChatBubble(message: messages[index]['message'],);
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  

  final String message;
  
  const ChatBubble({
    Key key, this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
     
      return Padding(
        padding:  EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
         
            SizedBox(
              width: 15,
            ),
            Flexible(
                          child: Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: getMessageType() 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: black,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    
  }
  getMessageType(){
   
    // for sender bubble

     
          return BorderRadius.all(Radius.circular(30));
        }
    
    
    
  
