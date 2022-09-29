import 'package:bfc/shared.dart';
import 'package:bfc/interpreter.dart';
import 'package:bfc/compiler.dart';

class Lexer {

  _lex(source, fileName, mode, options) {
    List<Command> tokens = [];
    List<String> chars = source.split("");
    bool hadError = false;
    bool allowComments = false;

    for (String option in options) {
      if (option == "allow_comments") {
        allowComments = true;
      }
    }

    for (String char in chars) {
      switch (char) {
        case '\n': break;
        case '\r': break;
        case '+' : {
          tokens.add(Command.increment);
        } 
          break;
        case '-': {
          tokens.add(Command.decrement);
        }
          break;
        case '>' : {
          tokens.add(Command.pointerShiftRight);
        }
          break;
        case '<': {
          tokens.add(Command.pointerShiftLeft);
        }
          break;
        case '.': {
          tokens.add(Command.write);
        }
          break;
        case ',': {
          tokens.add(Command.store);
        }
          break;
        case '[': {
          tokens.add(Command.leftBrace);
        }
          break;
        case ']': {
          tokens.add(Command.rightBrace);
        }
          break;

        default : {
          if (!allowComments) {
            print("Unexpected token: $char.");
            hadError = true;
          }
        }
          break;
      }
    }
    if (!hadError) {
      if (mode == "interpreter") {
      Interpreter interpreter = Interpreter();
      interpreter.run(tokens);
    } else if (mode == "compiler") {
      Compiler compiler = Compiler();
      compiler.run(tokens, fileName);
    }
    }
  }

  run(source, fileName, mode, options) {
    _lex(source, fileName, mode, options);
  }
}