# Changelog

### v1.1.0
* Change: Renamed `array_create` -> `array_of`, due to recent GameMaker update.
* Change: Renamed `array_copy` -> `array_clone`, due to recent GameMaker update.
* Change: `array_split(array, value)`, now returns 2D array instead of array of string.
* Change: Swapping functions have their names changed to minimize confusion. `*_swap(...)` -> `*_swap_item(...)`.
* Change: Most `array_*(...)` functions modified original array.
* Change: `real_is_*(number)` can take in non-numbers, but will return false.
* Change: Removed `deep` variable in `array_expand(...)`.
* Add: `array_is_1d(array)`, returns `true` if is 1D array, else false.
* Add: `array_sort(array)`, sorts numbers ascendingly, strings alphabetically.
* Add: `array_replace(array, index, value)`, replaces `array[index]` with `value`.
    * `array_replace(array, height, index, value)`, for 2D arrays.
* Add: `array_swap_item(array, index1, index2)`, swaps values at `index1` and `index2` in `array`.
    * `array_swap_item(array, height, index1, index2)`, for 2D arrays.
* Add: `ternary(comparison, true_value, false_value)`, if `comparison` is true, returns `true_value`, else `false_value`.
    * Compromise for `comparison ? true_value : false_value`.
* Add: `string_split(string, separator)`, returns array of string, where each item are the values of `string` split by `separator`.
* Add: `string_slice(string, from, to)`, returns a portion of `string` (`string[from .. to]`), where `from` is inclusive and `to` is exclusive. First character has index 0.
* Add: `string_substring(string, from, length)`, returns `length` amount of characters in `string` from `from`.
* Add: `string_find(source, find, [nth = 1])`, returns position of `nth` occurrence of `find` in `string`.
* Remove: `array_equal(array1, array2)`, use default GML `array_equals` instead.
* Remove: `object_destroy(id)`, use `with(instance) instance_destroy();` instead.
* Fix: `type_of(variable)` now supports data structures (`ds_*`).
* Fix: `array_at(height, index)` now appends correctly.
* Fix: `log(...)` now properly displays text.

* Change: `extensions_gme` -> `_gme`.
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
