// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChessBoardController _controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mate - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ChessBoard(
            controller: _controller,                // no longer "chessBoardController"
            boardColor: BoardColor.brown,           // not "boardType"
            boardOrientation: PlayerColor.white,    // flip if you want black at the bottom
            enableUserMoves: true,
            // The new flutter_chess_board uses onMove as a simple VoidCallback
            onMove: () {
              // Since onMove has no parameters, get the moves from the controller:
              final allMoves = _controller.getSan(); // returns a list of moves in SAN
              if (allMoves.isNotEmpty) {
                final lastMove = allMoves.last;      // get the most recent move
                print('Move made: $lastMove');
              } else {
                print('No moves yet');
              }
            },
          ),
        ),
      ),
    );
  }
}
