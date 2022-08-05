import 'dart:io';
import 'lexer.dart';

void main(List<String> args) async {
  void usageMenu() {
    print("\nUsage: bfc <file> <mode> <options>\n");
    print("<--------------------MODES-------------------->");
    print("run : Directly executes file. (Interpreter)");
    print("com : Turns file into runnable executable. (Compiler)\n");
    print("<--------------------OPTIONS-------------------->");
    print("-c : All the characters that the interpreter / compiler doesn't use will be ignored.\n");
  }

  if (args.length < 2) {
    usageMenu();
  } else {
    if (args.length == 2) {
      if (File(args[0]).existsSync()) {
      String source = File(args[0]).readAsStringSync();
      if (args[1].toLowerCase() == "com") {
        if (source.trim().isNotEmpty) {
            Lexer lexer = Lexer();
            lexer.run(source, args[0], "compiler", []);
          }
      } else if (args[1].toLowerCase() == "run") {
        if (source.trim().isNotEmpty) {
            Lexer lexer = Lexer();
            lexer.run(source, args[0], "interpreter", []);
          }
      } else {
        usageMenu();
      }
      } else {
        print("File '${args[0]}' does not exist in current directory.");
      }
    } else {
      List<String> options = [];
      if (File(args[0]).existsSync()) {
        String source = File(args[0]).readAsStringSync();
        if (args[1].toLowerCase() == "com") {
          for (String flag in args.sublist(2, args.length)) {
            if (flag == "-c") {
              options.add("allow_comments");
            } else {
              usageMenu();
              break;
            }
          }
          if (source.trim().isNotEmpty) {
            Lexer lexer = Lexer();
            lexer.run(source, args[0], "compiler", options);
          }
        } else if (args[1].toLowerCase() == "run") {
          for (String flag in args.sublist(2, args.length)) {
            if (flag == "-c") {
              options.add("allow_comments");
            } else {
              usageMenu();
              break;
            }
          }
          if (source.trim().isNotEmpty) {
            Lexer lexer = Lexer();
            lexer.run(source, args[0], "interpreter", options);
          }
        } else {
          usageMenu();
        }
      } else {
        print("File '${args[0]}' does not exist in current directory.");
      }
    }
  }
}