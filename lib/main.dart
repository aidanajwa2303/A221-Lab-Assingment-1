import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '#TOP10 Movie Information App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('#TOP10 Movie 2021 App')
        ),
        body: const MyMoviePage(),
      ),
      );
    }
  }

class MyMoviePage extends StatefulWidget {
  const MyMoviePage ({ Key? key }) : super(key: key);

  //final String title;

  @override
  _MyMoviePageState createState() => _MyMoviePageState();
}

class _MyMoviePageState extends State<MyMoviePage> {
  String selectMovie = "Spider-Man: No Way Home",
  description = "Choose your favorite movie",
  movie = "";
  
  var title, year, genre, runtime, director, writer, actors,plot;
  List<String> movieList = [
    "Spider-Man: No Way Home",
    "In the Heights",
    "Summer of Soul (...Or, When the Revolution Could Not Be Televised)",
    "Pig",
    "The Power of the Dog",
    "CODA",
    "Raya and the Last Dragon",
    "West Side Story",
    "A Quiet Place Part II",
    "The Mitchells vs the Machines",
  ];
  String desc = "No Data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text("Search your Movie here:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton(
              itemHeight: 60,
              value: selectMovie,
              onChanged: (newValue) {
                setState(() {
                  selectMovie = newValue.toString();
                });
              },
              items: movieList.map((selectMovie) {
                return DropdownMenuItem(
                  // ignore: sort_child_properties_last
                  child: Text(
                    selectMovie,
                  ),
                  value: selectMovie,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadMovie, child: const Text("Press Me")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    
          ],
        ),
      ),
    );
  }

  Future<void> _loadMovie() async {
    var apiid = "2aa525ec";
    var url = Uri.parse('https://www.omdbapi.com/?t=$selectMovie&apikey=$apiid');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      title = parsedData['Title'];
      year = parsedData['Year'];
      genre = parsedData['Genre'];
      runtime = parsedData['Runtime'];
      director = parsedData['Director'];
      writer = parsedData['Writer'];
      actors = parsedData['Actors'];
      plot = parsedData['Plot'];

      setState(() {
        desc =
            "Title: $title. \nRelease on: $year. \nGenre: $genre. \nRuntime: $runtime. \nDirector: $director. \nWriter: $writer. \nActors: $actors. \nPlot: $plot.";
            
      });

    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}