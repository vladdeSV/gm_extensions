# Changelog

### v1.1.0
* Add: Some `array_*()` functions now have optional parameter `inplace`. If true, function modifies original array.
* Add: `array_is_1d(...)`, `array_sort(...)`, `radix_sort_string(...)`), `array_replace(...)`, `array_swap(...)`.
    * `array_sort(...)` sorts reals by size, strings alphabetically.
* Fix: `type_of(variable)` now supports data structures (`ds_*`).
* Fix: `array_at(height, index)` now appends correctly.
* Fix: `log(...)` now properly displays text.

### v1.0.1
* `array_at(array, height, index)` overload not available in REFERENCE.md, fixes #1.
* Added `extension_gme`, which is inteded to provide `gm_extensions` specific functions.
    * Functions with optional arguments, or overloads should use new function `_gme_arguments(script, argument_count, count, counts...)`.
* For `//params: `, optional arguments are now surrounded with `[ ]`.
* `assert(...)` now properly stops code.
* Fixed newlines in `REFERENCE.md`.

### v1.0.0
Initial release of **GameMaker 1.4 Library Extensions**.
