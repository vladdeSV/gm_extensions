# Changelog

## v1.1.1
### Fixes
* `array_swap_item(...)` now calls `_gme_arguments(...)` correctly.

## v1.1.0

### Changed
* Renamed `array_create` -> `array_of`, due to recent GameMaker update.
* Renamed `array_copy` -> `array_clone`, due to recent GameMaker update.
* `array_split(array, value)`, now returns 2D array instead of array of string.
* Swapping functions have their names changed to minimize confusion. `*_swap(...)` -> `*_swap_item(...)`.
* Most `array_*(...)` functions modified original array.
* `array_*(...)` functions which modify arrays by reference have the array argument prefixed with an `&`, eg. `array_reverse(&array)`.
* `real_is_*(number)` can take in non-numbers, but will return false.
* Removed `deep` variable in `array_expand(...)`.

### Added
* `array_is_1d(array)`, returns `true` if is 1D array, else false.
* `array_sort(array)`, sorts numbers ascendingly, strings alphabetically.
* `array_replace(array, index, value)`, replaces `array[index]` with `value`.
    * `array_replace(array, height, index, value)`, for 2D arrays.
* `array_swap_item(array, index1, index2)`, swaps values at `index1` and `index2` in `array`.
    * `array_swap_item(array, height, index1, index2)`, for 2D arrays.
* `ternary(comparison, true_value, false_value)`, if `comparison` is true, returns `true_value`, else `false_value`.
    * Compromise for `comparison ? true_value : false_value`.
* `string_split(string, separator)`, returns array of string, where each item are the values of `string` split by `separator`.
* `string_slice(string, from, to)`, returns a portion of `string` (`string[from .. to]`), where `from` is inclusive and `to` is exclusive. First character has index 0.
* `string_substring(string, from, length)`, returns `length` amount of characters in `string` from `from`.
* `string_find(source, find, [nth = 1])`, returns position of `nth` occurrence of `find` in `string`.

### Removed
* `array_equal(array1, array2)`, use default GML `array_equals(var1, var2)` instead.
* `object_destroy(id)`, use `with(instance) instance_destroy();` instead.

### Fixes
* `type_of(variable)` now supports data structures (`ds_*`).
* `array_at(height, index)` now appends correctly.
* `log(...)` now properly displays text.

#### Minor
* Change: `extensions_gme` -> `_gme`.
* Fix: Clarified many parameters in functions.

## v1.0.1
* Change: For `//params: `, optional arguments are now surrounded with `[ ]`.
* Add: `extension_gme`, which is intended to provide `gm_extensions` specific functions.
    * Functions with optional arguments, or overloads should use new function `_gme_arguments(script, argument_count, count, counts...)`.
* Fix: `array_at(array, height, index)` overload not available in `REFERENCE.md`, fixes #1.
* Fix: `assert(...)` now properly stops code.
* Fix: newlines in `REFERENCE.md`.

## v1.0.0
Initial release of **GameMaker 1.4 Library Extensions**.
