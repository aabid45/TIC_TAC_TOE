class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlength = 9; // we'll create the board of 3*3 blocks
  static final blocksize = 100.0;

  // creating the empty board
  List<String>? board;
  static List<String>? initGameboard() =>
      List.generate(boardlength, (index) => Player.empty);
  // here we will build the winner check algorithm
  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    // first we'll declare the row and column
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == 'X' ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    // checking if we have 3 or -3 in the scoreboard
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    // by default it will return false
    return false;
  }
}
