import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

  //winner variable def
  var winner = '';

  //
  var currentplayer = 'X';
  void draw_x_o(i) {
    //i is the index
    if (grid[i] == '-') {
      setState(() {
        grid[i] = currentplayer; //current plyr is X defined above
        currentplayer = currentplayer == 'X'
            ? 'O'
            : 'X'; //if x then result O if O then return X
      });
      setState(() {
        findwinner(grid[i]);
      });
    }
  }

  //
  void reset() {
    setState(() {
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  // winner fun
  void findwinner(currentsign) {
    //i1,i2,i3 (indexes)
    if (checkMove(0, 1, 2, currentsign) ||
            checkMove(3, 4, 5, currentsign) ||
            checkMove(6, 7, 8, currentsign) || //row
            checkMove(0, 3, 6, currentsign) ||
            checkMove(1, 4, 7, currentsign) ||
            checkMove(2, 5, 8, currentsign) || //column
            checkMove(0, 4, 8, currentsign) ||
            checkMove(2, 4, 6, currentsign) //diagonal

        ) {
      setState(() {
        winner = currentsign;
        
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tic tac toe',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe', style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        ///3 columns
        // ignore: prefer_const_constructors
        body: Center(
          child: Column(
            children: [
              if(winner != '') Text(
                
                '$winner won the Game!' , style: TextStyle(fontSize: 30, color: Colors.green),
              ),
              Container(
                //responsiveness
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                margin: EdgeInsets.all(20),
                color: Colors.black, //grid color row column
                child: GridView.builder(
                    shrinkWrap: true,
                    // ignore: prefer_const_constructors
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: grid.length,
                    itemBuilder: (context, index) => Material(
                          color: Colors.amber, // backgroud colors of item
                          child: InkWell(
                            splashColor: Colors
                                .blue, //when clicked its bakgoud color showclick
                            onTap: () => draw_x_o(index),
                            child: Center(
                                child: Text(
                              grid[index],
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontSize:
                                      50), //shift+alt+F //for code formating
                            )),
                          ),
                        )),
              ),
              ElevatedButton.icon(
                  onPressed: reset,
                  icon: Icon(Icons.refresh),
                  label: Text('play again!'))
            ],
          ),
        ),
      ),
    );
  }
}
