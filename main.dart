//import and main function
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

//TicTacToe app widget
class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TicTacToe(),
    );
  }
}

//TicTacToe Stateful Widget
class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

//TicTacToeState Class
class _TicTacToeState extends State<TicTacToe> {
  //Game Board and Variables
  List<String> board = List.filled(9, ""); // Initialize an empty board
  String currentPlayer = "X"; // Start with player X
  String? winner;

  //makeMove Function
  void makeMove(int index) {
    if (winner == null && board[index] == "") {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = (currentPlayer == "X") ? "O" : "X"; // Switch players
        winner = checkForWin();
      });
    }
  }

  //checkForWin Function
  String? checkForWin() {
    // Define winning combinations
    List<List<int>> winCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winCombinations) {
      if (board[combo[0]] != "" &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[0]] == board[combo[2]]) {
        return board[combo[0]];
      }
    }

    if (!board.contains("")) {
      return "Draw"; // No winner, and the board is full, indicating a draw
    }

    return null; // No winner yet
  }

  //resetGame Function
  void resetGame() {
    setState(() {
      board = List.filled(9, "");
      currentPlayer = "X";
      winner = null;
    });
  }

  //buildSquare Function
  Widget buildSquare(int index) {
    return GestureDetector(
      onTap: () => makeMove(index),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          board[index],
          style: const TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }

  //build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic-Tac-Toe"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display game status
            Text(
              (winner == null)
                  ? "Player $currentPlayer's turn"
                  : (winner == "Draw")
                      ? "It's a Draw!"
                      : "Player $winner wins!",
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),

            // Display the game board
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return buildSquare(index);
              },
            ),
            const SizedBox(height: 20.0),

            // Reset button
            ElevatedButton(
              onPressed: resetGame,
              child: const Text("Reset Game"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('winner', winner));
  }
}
