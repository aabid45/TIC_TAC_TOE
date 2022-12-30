import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_logic.dart';
import 'package:tic_tac_toe/ui/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Gamescreen(),
    );
  }
}

class Gamescreen extends StatefulWidget {
  const Gamescreen({super.key});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  //adding the necessory variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //for different combination of game{row, column, diagonal}
  // let's declare a new game component
  Game game = Game();
  // now let's initi the game board
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameboard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: maincolor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue}'s Turn:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
          SizedBox(height: 20.0),
          // Now we'll create the game board
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlength ~/
                  3, // ~/ Use to divide two operands but give output in integer
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          // When we click we need to add the new value to the board
                          // we need to toggle the player also
                          // Now we need to apply the click only if the field is empty
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreboard, 3);
                              if (gameOver) {
                                result = "$lastValue is the winner🎉";
                              } else if (!gameOver && turn == 9) {
                                result = "It's a Draw😑";
                                gameOver = true;
                              }
                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocksize,
                    height: Game.blocksize,
                    decoration: BoxDecoration(
                      color: maincolor.secondaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.black
                                : Colors.white,
                            fontSize: 60.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 25.0),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
          // here we will create the button to repeat the game
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                // Erade the board
                game.board = Game.initGameboard();
                lastValue = 'X';
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.repeat),
            label: Text("Repeat the game"),
          )
        ],
      ),
    );
  }
}
