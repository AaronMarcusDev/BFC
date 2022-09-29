import 'package:bfc/shared.dart';

class Compiler {
  //Code generation from tokens.
  _generate(List<Command> tokens) {
    List<String> code = [];
    // The List will contain all the generated C lines.
    int openLoopAmount = 0;
    int closeLoopAmount = 0;
    // These two are important for error checking,
    // we don't want to generate faulty C code.

    // Initializing program
    code.add("#include <stdio.h>;");
    code.add("int main() {");
    code.add("  /* Program start */");
    code.add("  /* Initializing memory array */");
    code.add("  char memory[30000] = {0};");
    code.add("  char *ptr = memory;");
    code.add("  /* Commands */");

    for (int c = 0; c < tokens.length; c++) {
      Command command = tokens[c];

      switch (command) {
        case Command.increment:
          {
            code.add("  ++*ptr;");
          }
          break;

        case Command.decrement:
          {
            code.add("  --*ptr;");
          }
          break;

        case Command.pointerShiftRight:
          {
            code.add("  ++ptr;");
          }
          break;

        case Command.pointerShiftLeft:
          {
            code.add("  --ptr;");
          }
          break;

        case Command.write:
          {
            code.add("  putchar(*ptr);");
          }
          break;

        case Command.store:
          {
            code.add("  *ptr = getchar();");
          }
          break;

        case Command.leftBrace:
          {
            code.add("  while (*ptr) {");
            openLoopAmount++;
          }
          break;

        case Command.rightBrace:
          {
            code.add("  }");
            closeLoopAmount++;
          }
          break;
      }
    }

    if (openLoopAmount == closeLoopAmount) {
      code.add("}");
      return code;
    } else {
      stdout.write(
          "Code generation error: amount of loop openings '[, does not equal amount of loop endings ']'.");
      exit(1);
    }
  }

  //Joins code lines, creates file and runs TCC in shell.
  _compile(List<String> lines, String fileName) async {
    String fileContent = lines.join("\n");
    await File(fileName).writeAsString(fileContent);
    await Process.run('.\\tcc\\tcc.exe', [fileName], runInShell: true);
    File(fileName).delete();
  }

  //Function to be called from main function.
  run(List<Command> tokens, fileName) {
    if (fileName.contains(".")) {
      List<String> dotSplit = fileName.split(".");
      String cFileName =
          "${dotSplit.sublist(0, dotSplit.length - 1).join("")}.c";
      _compile(_generate(tokens), cFileName);
    } else {
      String cFileName = "$fileName.c";
      _compile(_generate(tokens), cFileName);
    }
  }
}
