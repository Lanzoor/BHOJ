# Bro Had One Job Language Compiler

> Welcome to the Bro Had One Job _(BHOJ)_ Language Compiler!

BHOJ is an **esoteric programming language**, that gets compiled into **Brainfuck code**, which is another esoteric programming language.

The language has **8 tokens that you can use, and they are:**

| Token | Brainfuck Result | Function                                                                     |
| :---: | :--------------: | :--------------------------------------------------------------------------- |
| `bro` |       `<`        | Moves the pointer to the left                                                |
| `had` |       `>`        | Moves the pointer to the right                                               |
| `one` |       `+`        | Increments the cell                                                          |
| `job` |       `-`        | Decrements the cell                                                          |
| `ts`  |       `.`        | Prints the ASCII value of the cell                                           |
| `pmo` |       `,`        | Reads one byte of input, and stores its ASCII value in the current cell      |
| `😭`  |       `[`        | Starts a loop. If the current cell is zero, jumps forward to the matching ]. |
| `🥀`  |       `]`        | Ends a loop. If the current cell is non-zero, jumps back to the matching [.  |

> **_NOTE: This program does not interpret the compiled Brainfuck code. You will need a separate Brainfuck interpreter for this._**

## Installation

```sh
cd ~/Downloads
git clone https://github.com/Lanzoor/BHOJ.git
cd BHOJ
./install.sh
```

You can uninstall BHOJ from your device by running the installation script again. **You will see an uninstall option.**

## Example in BHOJ

Here's an example of a BHOJ code.

```
one one one one one one one one one one 😭 had one one one one one one one had one one one one one one one one one one had one one one had one bro bro bro bro job 🥀 had one one ts had one ts one one one one one one one ts ts one one one ts had one one ts bro bro one one one one one one one one one one one one one one one ts had ts one one one ts job job job job job job ts job job job job job job job job ts had one ts had ts
```

When you compile this BHOJ code, it gets compiled into this Brainfuck code;

```
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.
```

And, when you run this exact Brainfuck code, it prints out;

```
Hello, World!
```
