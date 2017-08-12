# Changelog

### v1.1.0
* Change: Most `array_*()` functions modified original array.
* Change: Removed `deep` variable in `array_expand(...)`.
* Change: Swapping functions have their names changed to minimize confusion. `*_swap(...)` -> `*_swap_item(...)`.
* Change: `extensions_gme` -> `_gme`
* Add: `array_is_1d(...)`, `array_sort(...)`, `array_replace(...)`, `array_swap(...)`.
    * `array_sort(...)` sorts reals by size, strings alphabetically.
* Fix: `type_of(variable)` now supports data structures (`ds_*`).
* Fix: `array_at(height, index)` now appends correctly.
* Fix: `log(...)` now properly displays text.
* Fix: Typo in CHANGELOG.md.

### v1.0.1
* Change: For `//params: `, optional arguments are now surrounded with `[ ]`.
* Add: `extension_gme`, which is intended to provide `gm_extensions` specific functions.
    * Functions with optional arguments, or overloads should use new function `_gme_arguments(script, argument_count, count, counts...)`.
* Fix: `array_at(array, height, index)` overload not available in `REFERENCE.md`, fixes #1.
* Fix: `assert(...)` now properly stops code.
* Fix: newlines in `REFERENCE.md`.

### v1.0.0
Initial release of **GameMaker 1.4 Library Extensions**.
