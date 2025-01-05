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

  // In a real app, you might retrieve the JWT from your global app state or
  // from a secure storage. For demonstration, I'm just hard-coding
  // or leaving it blank.
  final String _dummyToken = 'YOUR_JWT_TOKEN_FROM_LOGIN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mate - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile
              Navigator.pushNamed(context, '/profile', arguments: _dummyToken);
            },
          ),
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
            controller: _controller,
            boardColor: BoardColor.brown,
            boardOrientation: PlayerColor.white,
            enableUserMoves: true,
            onMove: () {
              final allMoves = _controller.getSan();
              if (allMoves.isNotEmpty) {
                final lastMove = allMoves.last;
                print('Move made: $lastMove');
              }
            },
          ),
        ),
      ),
    );
  }
}
