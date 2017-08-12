# Changelog

### v1.1.0
* Change: Renamed `array_create` -> `array_of`, due to recent GameMaker update.
* Change: Renamed `array_copy` -> `array_clone`, due to recent GameMaker update.
* Change: Most `array_*(...)` functions modified original array.
* Change: Removed `deep` variable in `array_expand(...)`.
* Change: Swapping functions have their names changed to minimize confusion. `*_swap(...)` -> `*_swap_item(...)`.
* Change: `extensions_gme` -> `_gme`.
* Add: `array_is_1d(array)`, returns `true` if is 1D array, else false.
* Add: `array_sort(array, [ascending = true])`, sorts numbers by size, strings alphabetically.
* Add: `array_replace(array, index, value)`, replaces `array[index]` with `value`.
    * `array_replace(array, height, index, value)`, for 2D arrays.
* Add: `array_swap_item(array, index1, index2)`, swaps values at `index1` and `index2` in `array`.
    * `array_swap_item(array, height, index1, index2)`, for 2D arrays.
* Add: `ternary(comparison, true_value, false_value)`, if `comparison` is true, returns `true_value`, else `false_value`.
    * Compromise for `comparison ? true_value : false_value`.
* Remove: `array_equal(array1, array2)`, use default GML `array_equals` instead.
* Fix: `type_of(variable)` now supports data structures (`ds_*`).
* Fix: `array_at(height, index)` now appends correctly.
* Fix: `log(...)` now properly displays text.
* Fix: Clarified many parameters in functions.

### v1.0.1
* Change: For `//params: `, optional arguments are now surrounded with `[ ]`.
* Add: `extension_gme`, which is intended to provide `gm_extensions` specific functions.
    * Functions with optional arguments, or overloads should use new function `_gme_arguments(script, argument_count, count, counts...)`.
* Fix: `array_at(array, height, index)` overload not available in `REFERENCE.md`, fixes #1.
* Fix: `assert(...)` now properly stops code.
* Fix: newlines in `REFERENCE.md`.

### v1.0.0
Initial release of **GameMaker 1.4 Library Extensions**.
