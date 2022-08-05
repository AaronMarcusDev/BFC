# Brainfuck-Compiler-and-Interpreter (BFC)
## Description
An Interpreter and Compiler for the Brainfuck esoteric programming language.

## Installation

Download the zip-file containing BFC and TCC from the [BFC release page](https://github.com/AaronMarcusDev/BFC/releases).

Make sure to place the folder containing BFC in a system location.

The location **C:\bfc** (for windows)  is recommended.

Don't forget to [add this folder to PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/).
## Brainfuck-language
Learn more about the well-known esoteric programming language:

- [Esolangs](https://esolangs.org/wiki/Brainfuck)
- [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck)
- [Brainfuck](http://brainfuck.org/)

## Usage

You can run BFC from the command line after adding it to **PATH**.

```bash
CLI:
    $ bfc <file> <mode> <optional-flags>

Modes:
    run : Directly executes file. (Interpreter)
    com : Turns file into runnable executable. (Compiler)

Options:
    -c : All the characters that Brainfuck does not use will be ignored. (BF standard)
```

## How it works
BFC is written in the [Dart language](https://dart.dev).
### The compiling process

- **B --> C --> TCC --> .EXE**

- The **Lexer** takes the source-file (**.b**) and transforms it into **tokens** called **Commands**.

- The **Code-Generator** takes these tokens and generates the **C-IR** equivalent.

- The **Compiler** takes these lines, writes them into a **C-file** file and calls **TCC** to compile the file.

Voilà, you have now an executable form of your Brainfuck program.

### The interpreter
- The **Lexer** takes the source-file (**.b**) and transforms it into tokens called **Commands**.

- The **Interpreter** takes these tokens and executes them.

- It simulates **memory** using a List / Array and uses a integer to keep track of the **pointer**.

## Notes and Todo

**Notes**
- The Brainfuck compiler is currently **ONLY** working on the windows platform. 
- BFC will report all characters besides the ones used by Brainfuck as errors, unless you use the **-c** flag.

**Todo**

- Linux support.
- MacOS support?

## Contributing
I will keep updating BFC myself.

But, feel free to request new features and report bugs at the [issues page](https://github.com/AaronMarcusDev/BFC/issues).

## License
BFC uses the [MIT license](https://choosealicense.com/licenses/mit/).
