import 'package:flutter/material.dart';
import 'package:natureslink/dbHelper/MongoDbModel.dart';
import 'package:natureslink/dbHelper/mongodb.dart';

class insertVidTut extends StatefulWidget {
  const insertVidTut({Key? key}) : super(key: key);

  @override
  State<insertVidTut> createState() => _insertVidTutState();
}

class _insertVidTutState extends State<insertVidTut> {
  var linkController = new TextEditingController();
  var titleController = new TextEditingController();
  var descriptionController = new TextEditingController();

  var linkControllernull = new TextEditingController();
  var titleControllernull = new TextEditingController();
  var descriptionControllernull = new TextEditingController();

  Widget buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Spacer(),
                Text(
                  'Insert Videos',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoInfo() => Card(
        color: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: linkController,
                decoration:
                    (InputDecoration(labelText: "Youtube Video Link: ")),
              ),
              TextField(
                controller: titleController,
                decoration: (InputDecoration(labelText: "Title: ")),
              ),
              TextField(
                controller: descriptionController,
                minLines: 3,
                maxLines: 20,
                decoration: (InputDecoration(labelText: "Description: ")),
              ),
            ],
          ),
        ),
      );

  Widget buildInsertVid() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          if (linkController.text.isEmpty || titleController.text.isEmpty || descriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Please Insert Data")));
          } else {
            _insertVidData(linkController.text, titleController.text,
                descriptionController.text);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Videos Inserted!")));
            Navigator.pop(context);
          }
        },
        child: Text(
          'Insert',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _insertVidData(
    String link,
    String title,
    String overview,
  ) async {
    final viddata = videoTutModel(
      link: link,
      title: title,
      overview: overview,
    );
    var result = await videoTutorial.insertVT(viddata);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:
            const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeader(context),
              SizedBox(height: 20),
              buildVideoInfo(),
              SizedBox(height: 20),
              buildInsertVid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
