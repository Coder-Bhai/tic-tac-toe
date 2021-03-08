import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}
double emptyPlaces = 9;
bool oTurn = true;
final List<String> ox = ['', '', '', '', '', '', '', '', ''];

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Tic Tac Toe',
              style: myFont,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height/2.001,
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _onTapped(index);
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          '${ox[index]}',
                          style: gameFont,
                        ),
                      ),
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                    ),
                  );
                }),
          ),
          Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              splashColor: Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
               _resetGame();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Reset', style: myFont)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _onTapped(int index) {
    if (oTurn && ox[index] == '') {
      ox[index] = 'O';
      emptyPlaces--;

    } else if (oTurn == false && ox[index] == '') {
      ox[index] = 'X';
      emptyPlaces--;

    }
    oTurn = !oTurn;
    _checkWinner();
  }

  void _checkWinner() {
    if (ox[0] == ox[1] && ox[0] == ox[2] && ox[0] != '')
      _declareWinner(ox[0]);
    else if (ox[0] == ox[3] && ox[0] == ox[6] && ox[0] != '')
      _declareWinner(ox[0]);
    else if (ox[3] == ox[4] && ox[3] == ox[5] && ox[3] != '')
      _declareWinner(ox[3]);
    else if (ox[1] == ox[4] && ox[1] == ox[7] && ox[1] != '')
      _declareWinner(ox[1]);
    else if (ox[6] == ox[7] && ox[6] == ox[8] && ox[6] != '')
      _declareWinner(ox[6]);
    else if (ox[2] == ox[5] && ox[2] == ox[8] && ox[2] != '')
      _declareWinner(ox[2]);
    else if (ox[0] == ox[4] && ox[0] == ox[8] && ox[0] != '')
      _declareWinner(ox[0]);
    else if (ox[2] == ox[4] && ox[2] == ox[6] && ox[2] != '')
      _declareWinner(ox[2]);
    else if(emptyPlaces==0) {
      _drawGame();
    };
  }

  void _drawGame() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 100,
          width: 100,
          child: Center(child: Text('Game Draw', style: GoogleFonts.pressStart2p(fontSize: 20.0 ,color: Colors.black), textAlign: TextAlign.center,)),
          decoration: BoxDecoration(
              color: Colors.white
          ),
        ),
      );
    });
  }

  void _declareWinner(String champion) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 100,
          width: 100,
          child: Center(child: Text('Winner ${champion} 🎉', style: GoogleFonts.pressStart2p(fontSize: 20.0 ,color: Colors.black), textAlign: TextAlign.center,)),
          decoration: BoxDecoration(
            color: Colors.white
          ),
        ),
      );
    });
  }

  void _resetGame() {
    setState(() {
      for(int i=0;i<9;i++)
      {
        ox[i]='';
      }
      emptyPlaces=9;
    });
  }
}



TextStyle myFont =
    GoogleFonts.pressStart2p(fontSize: 20.0, color: Colors.white);
TextStyle gameFont =
    GoogleFonts.pressStart2p(fontSize: 40.0, color: Colors.black);

