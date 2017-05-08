# GameMaker 1.4 Library Extensions
The purpose of this library is to add missing features from the standard GameMaker 1.4 library.

### Rules for scripts
**"Set in Stone"-rules**.

1. All scripts must begin with a "triple slash" comment, followed by the function name and arguments in the following syntax: `///<function>(arg1, [arg2, ..., argn])`.
    1. The function name must be equal to the script file name.
    1. Argument names should match their purpose as much as possible.
    1. Optional arguments must be surrounded by square brackets `[]`.
1. All scripts must contain a description by including the following:
    1. `params:` The types of the arguments. If type subsets are used, display in parentheses. Example: `//params: string, array, real, real (bool), real (natural)`.
    1. `results:`/`returns:`: Brief description what the function does, or the what is to be returned.
1. In code, where optional arguments are available, all arguments must be addressed via the argument array, in the manner of `argument[n]`, and if necessary include a argument limiter. If a script takes a specified set of arguments, all arguments must be addressed via the default argument accessors, by `argument0`.
1. All argumnts must be assigned to a variable at the start of function.
    * All assertion tests on arguments must be placed underneath.
1. All assertion checks must follow syntax `<function>(...): <error message>`.
    * Example of `array_init(length)`, `assert(length >= 0, "array_init(...): Length must be positive");`
1. In unittests, all variables must be initialized.

**"Loose" rules**, meaning not as strict.
1. All code must be well structured, with proper variable names.
1. Variables referenced in comments should be surrounded with back-ticks (`) including script description
1. All files should end with an empty line.
1. All usage of `++` and `--` must come before variable names (`--position`, `++lpos`), unless explicitly required.

### Acknowledgments
Special thanks to @twisterghost (Michael Barrett) for inspiration with his library 'gdash'
