import 'command.dart';
import 'dart:io';

class Interpreter {

  void _interpret(List<Command> tokens) {
  List<int> data = List.filled(30000, 0); // Simulated memory
  List<int> loopList = [];
  int nestedLoops = 0; // Keeps track of loops-in-loops
  bool inLoop = false;
  int pos = 0; // Simulates pointer (ptr)
  
  for (int c  = 0; c < tokens.length; c++) {
    Command command = tokens[c];

    if (inLoop) {
      if (command == Command.leftBrace) {
        nestedLoops++;
      } else if (command == Command.rightBrace) {
        nestedLoops == 0
        ? inLoop = false
        : nestedLoops--;
      }
      continue;
    }

    switch (command) {
      case Command.increment: {
        data[pos]++;
      }
      break;

      case Command.decrement: {
        data[pos]--;
      }
      break;

      case Command.pointerShiftRight: {
        pos == data.length
        ? pos = 0
        : pos++;
      }
      break;

      case Command.pointerShiftLeft: {
        pos == 0
        ? pos = data.length
        : pos--;
      }
      break;

      case Command.write: {
        stdout.write(String.fromCharCode(data[pos]));
      }
      break;

      case Command.store: {
        try {
          data[pos] = stdin.readByteSync();
        } catch(e) {
          print("Runtime error: byte is not in exclusive range.");
        }
        
      }
      break;

      case Command.leftBrace: {
        data[pos] == 0 
        ? inLoop = true 
        : loopList.add(c);
      }
      break;

      case Command.rightBrace: {
        data[pos] != 0 
        ? c = loopList[loopList.length - 1]
        : loopList.removeLast();
      }
      break;
    }
  }
}
void run(List<Command> tokens) {
    _interpret(tokens);
  }
}