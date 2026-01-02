import sys, pathlib
from lib.styles import *

APP_NAME = "Bro Had One Job Compiler"
VERSION = "1.0.2"

HELP_FLAGS = {"-h", "--help"}
REVERSE_FLAGS = {"-r", "--reverse"}
OUTPUT_FLAGS = {"-o", "--output"}

def kill_program(message: str, code: int = 0):
    print(fore(message, RED))
    sys.exit(code)

NAME_TAG = fore(f"{APP_NAME} v{VERSION}", BLUE)

def print_help():
    print(
        f"""{NAME_TAG}

Usage:
  bhoj <file> [options]

Options:
  -h, --help            Show this help message
  -r, --reverse         Convert Brainfuck → BHOJ
  -o, --output <file>   Write output to specific file

Examples:
  bhoj program.bhoj
  bhoj program.bhoj -o out.bf
  bhoj program.bf --reverse
"""
    )
    sys.exit(0)


args = sys.argv[1:]

if not args or HELP_FLAGS & set(args):
    print_help()

reverse = bool(REVERSE_FLAGS & set(args))

output_path = None
if OUTPUT_FLAGS & set(args):
    try:
        idx = next(i for i, a in enumerate(args) if a in OUTPUT_FLAGS)
        output_path = args[idx + 1]
    except (StopIteration, IndexError):
        kill_program("Error: -o / --output requires a file path")

    del args[idx : idx + 2] # type: ignore

args = [a for a in args if a not in REVERSE_FLAGS]

if len(args) != 1:
    kill_program("Error: expected exactly one input file\nUse --help for usage")

input_path = pathlib.Path(args[0]).expanduser().resolve()

if not input_path.is_file():
    kill_program(f"Error: file not found: {input_path}")

token_map = {
    "bro": "<",
    "had": ">",
    "one": "+",
    "job": "-",
    "ts": ".",
    "pmo": ",",
    "😭": "[",
    "🥀": "]",
}

if reverse:
    token_map = {v: k for k, v in token_map.items()}

code = input_path.read_text(encoding="utf-8")
output: list[str] = []

if reverse:
    for char in code:
        if char in token_map:
            output.append(token_map[char])
else:
    tokens = code.lower().split()
    for token in tokens:
        if token in token_map:
            output.append(token_map[token])

compiled = "".join(output) if not reverse else " ".join(output)

if output_path:
    out = pathlib.Path(output_path).expanduser()
    if not out.parent.exists():
        kill_program(f"Error: output directory does not exist: {out.parent}")
else:
    suffix = ".bf" if not reverse else ".bhoj"
    out = input_path.with_suffix(suffix)

out.write_text(compiled, encoding="utf-8")

print(fore(f"Wrote output to {out}", GREEN))
