// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:Mate/auth_state.dart';

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
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Go to profile
              // We'll push with named route, no need to pass the token since profile_page
              // can read from AuthState
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Log out logic: Clear AuthState, go back to login
              AuthState.token = null;
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
                print('Move made: ${allMoves.last}');
              }
            },
          ),
        ),
      ),
    );
  }
}
