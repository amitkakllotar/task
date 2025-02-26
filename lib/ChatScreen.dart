import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<Message> messages = [
    Message(
        sender: "Flash",
        text: "@ironman help us out",
        time: "10:16am",
        isUser: false),
    Message(
        sender: "You", text: "Awesome! Thanks.", time: "11:14am", isUser: true),
    Message(
        sender: "Black Widow",
        text: "Hey team, I've finished with the requirements doc!",
        time: "1:40am",
        isUser: false),
    Message(
        sender: "You", text: "Awesome! Thanks.", time: "11:14am", isUser: true),
    Message(
        sender: "Wonder Woman",
        text: "Good timing — was just looking at this.",
        time: "11:44am",
        isUser: false),
    Message(
        sender: "You",
        text: "",
        time: "11:14am",
        isUser: true,
        isImage: true), // Placeholder for image
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3B8A8B), // Adjust color to match the image
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              const Text(
                'Group Chat',
                style: TextStyle(
                  fontFamily: "Trajan Pro",
                  fontSize: 28, // Large font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust text color
                ),
              ),
              const Text(
                'Hi, <Username>',
                style: TextStyle(
                  fontFamily: "Schyler",
                  fontSize: 10, // Smaller secondary text
                  color: Colors.white70, // Slightly dimmer color
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ChatBubble(message: messages[index]);
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                  color: Color(0xFF438E96),
                )),
                color: Colors.white,
              ),
              width: 350,
              height: 90,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Message',
                        fillColor: Color(0xFFDDEFF0),
                        filled: true,
                        prefixIcon: Icon(Icons.emoji_emotions_outlined,
                            color: Color(0xFF438E96)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF438E96))),
                        suffixIcon: Icon(Icons.image_outlined,
                            color: Color(0xFF438E96)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFF438E96),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              )),
        ));
  }

}

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFDDEFF0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Text(message.sender,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 5),
            message.isImage
                ? Image.network(
                    "https://via.placeholder.com/150") // Replace with actual image URL
                : Text(message.text, style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(message.time,
                style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time;
  final bool isUser;
  final bool isImage;

  Message(
      {required this.sender,
      required this.text,
      required this.time,
      this.isUser = false,
      this.isImage = false});
}
