# Changelog

### current
**Changes**
* Fixed newlines in `REFERENCE.md`.

### v1.0.1
**Changes**
* `array_at(array, height, index)` overload not available in REFERENCE.md, fixes #1.
* Added `extension_gme`, which is inteded to provide `gm_extensions` specific functions.
    * Functions with optional arguments, or overloads should use new function `_gme_arguments(script, argument_count, count, counts...)`.
* For `//params: `, optional arguments are now surrounded with `[ ]`.

### v1.0.0
Initial release of **GameMaker 1.4 Library Extensions**.
