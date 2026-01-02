BRIGHT = 60

BLACK = 0
RED = 1
GREEN = 2
YELLOW = 3
BLUE = 4
MAGENTA = 5
CYAN = 6
WHITE = 7
DEFAULT_COLOR = 9

BRIGHT_BLACK = BRIGHT + BLACK
BRIGHT_RED = BRIGHT + RED
BRIGHT_GREEN = BRIGHT + GREEN
BRIGHT_YELLOW = BRIGHT + YELLOW
BRIGHT_BLUE = BRIGHT + BLUE
BRIGHT_MAGENTA = BRIGHT + MAGENTA
BRIGHT_CYAN = BRIGHT + CYAN
BRIGHT_WHITE = BRIGHT + WHITE

def fore(message: str, color: int | list[int] | tuple[int, int, int], *, disable: bool = False) -> str:
    if disable: return message

    if isinstance(color, int):
        if (color > 7 and color != 9 and color < 60) or (color > 67): raise Exception("Unsupported default terminal color.")
        try:
            return f"\033[{(30 + color)}m{message}\033[39m"
        except ValueError:
            return message
    else:
        red, green, blue = color
        return f"\033[38;2;{red};{green};{blue}m{message}\033[39m"

def bold(string: str, *, disable: bool = False) -> str:
    if disable: return string
    return f"\033[1m{string}\033[22m"
