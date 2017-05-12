# GameMaker 1.4 Library Extensions Reference
## Reference

### extension_algorithm

1. [quick_sort](#quick_sort)

### extension_array

1. [array_init](#array_init)
1. [array_create](#array_create)
1. [array_slice](#array_slice)
1. [array_copy](#array_copy)
1. [array_at](#array_at)
1. [array_append](#array_append)
1. [array_equal](#array_equal)
1. [array_split](#array_split)
1. [array_sub](#array_sub)
1. [array_reverse](#array_reverse)
1. [array_find](#array_find)
1. [array_count](#array_count)
1. [array_exists](#array_exists)
1. [array_expand](#array_expand)
1. [array_length](#array_length)
1. [array_height](#array_height)
1. [array_insert](#array_insert)
1. [array_string](#array_string)
1. [array_sort](#array_sort)
1. [array_is_1d](#array_is_1d)
1. [array_is_empty](#array_is_empty)

### extension_ds_list

1. [ds_list_swap](#ds_list_swap)

### extension_misc

1. [log](#log)
1. [assert](#assert)
1. [noop](#noop)
1. [type_of](#type_of)

### extension_object

1. [object_destroy](#object_destroy)

### extension_real

1. [real_within](#real_within)
1. [real_within_exlusive](#real_within_exlusive)
1. [real_is_integer](#real_is_integer)
1. [real_is_natural](#real_is_natural)

### extension_string

1. [string_text](#string_text)
1. [string_join](#string_join)


---

## extension_algorithm

### [quick_sort](/scripts/extension_algorithm.gml#L4)

##### quick_sort(array)
params: array (real)  
returns: array of reals sorted  

## extension_array

### [array_init](/scripts/extension_array.gml#L5)

##### array_init(length)
params: real (natural)  
returns: array with `length` items  

##### array_init(height, length)
params: real (natural), real (natural)  
retruns: array with `height` * `length` items  

### [array_create](/scripts/extension_array.gml#L46)

##### array_create(arg, ...)
params: value, value...  
returns: creates an array from arguments  

### [array_slice](/scripts/extension_array.gml#L73)

##### array_slice(array, from, to)
params: array, real (natural), real (natural)  
retruns: portion of `array`. `from` (inclusive), `to` (exclusive). if `from` == `to`, returns 0  

### [array_copy](/scripts/extension_array.gml#L100)

##### array_copy(array)
params: array  
returns: deep copy of `array`, both 1D and 2D arrays  

### [array_at](/scripts/extension_array.gml#L133)

##### array_at(array, index)
params: array, real (natural)  
returns: element in `array` at `index` (`array[subindex, index]`)  

##### array_at(array, height, index)
params: array, real (natural), real (natural)  
returns: element in `array` at `height, index` (`array[height, index]`)  

### [array_append](/scripts/extension_array.gml#L166)

##### array_append(array, value)
params: array, value  
results: appends `value` to `array`. arrays are pointers, no need to return array  

##### array_append(array, height, value)
params: array, real (natural), value  
results: appends `value` to `array` at `height`. arrays are pointers, no need to return array  

### [array_equal](/scripts/extension_array.gml#L199)

##### array_equal(array1, array2)
params: array, array  
returns: true if the content of `array1` and `array2` are equal  

### [array_split](/scripts/extension_array.gml#L237)

##### array_split(string, separator)
params: string, string  
returns: array of strings (`array_split("one,2,five", ",") == ["one", "2", "five"]`)  

### [array_sub](/scripts/extension_array.gml#L276)

##### array_sub(array, height)
param: array, real (natural)  
retruns: 1D array from 2D array at position `height`  

### [array_reverse](/scripts/extension_array.gml#L297)

##### array_reverse(array, [inplace = false])
params: array, [real (bool)]  
results: `array` with items in reverse order. modifies original array if `inplace` == true  

### [array_find](/scripts/extension_array.gml#L338)

##### array_find(array, value, [nth = 1])
params: array, real (natural), [real (natural)]  
returns: nth position where value is found in 1D array. if not found, returns -1  

### [array_count](/scripts/extension_array.gml#L365)

##### array_count(array, value)
params: array, value  
returns: count of how many of value exists in array  

### [array_exists](/scripts/extension_array.gml#L390)

##### array_exists(array, value)
params: array, value  
returns: count of how many of value exists in array  

### [array_expand](/scripts/extension_array.gml#L413)

##### array_expand(array, [deep = -1])
params: array, [real (natural)]  
returns: returns array of all elements of nested arrays, to `deep` layers down. if `deep` == -1, expand all  

### [array_length](/scripts/extension_array.gml#L464)

##### array_length(array, [height = 0])
params: array, [real (natural)]  
retruns: length of `array`, at height `height`  

### [array_height](/scripts/extension_array.gml#L484)

##### array_height(array)
params: array  
retruns: height of `array`. note: all arrays have a height, including 1D arrays which have the height of 1.  

### [array_insert](/scripts/extension_array.gml#L499)

##### array_insert(array, position, value, [inplace = false])
params: array, real (natural), value, [real (bool)]  
returns: `array` with `value` inserted at `array[position]`. modifies original if `inplace` == true  

### [array_string](/scripts/extension_array.gml#L539)

##### array_string(string)
params: string  
retruns: array with each item as string characters  

### [array_sort](/scripts/extension_array.gml#L557)

##### array_sort(array, [ascending = true, inplace = false])
params: array, real (bool), real (bool)  
retruns: array with elements sorted. all items in `array` must be same type  

### [array_is_1d](/scripts/extension_array.gml#L595)

##### array_is_1d(array)
params: array  
retruns: true if `array` height == 1, or `array` == empty 1D array  

### [array_is_empty](/scripts/extension_array.gml#L618)

##### array_is_empty(array)
params: array  
returns: true if array is "empty" (by gm_extensoins definition)  

## extension_ds_list

### [ds_list_swap](/scripts/extension_ds_list.gml#L5)

##### ds_list_swap(id, index_1, index_2)
params: ds_list, real (natural), real (natural)  
results: swaps two elements, `index_1` and `index_2`, in a ds_list  

## extension_misc

### [log](/scripts/extension_misc.gml#L5)

##### log(...)
params: value...  
results: shorthand for `show_debug_message`  

### [assert](/scripts/extension_misc.gml#L18)

##### assert(comparison, [message])
params: real (boolean), string  
results: if `comparison` is false, show `message` and exit  

### [noop](/scripts/extension_misc.gml#L43)

##### noop()
results: nothing. noop is shorthand for "no operation"  

### [type_of](/scripts/extension_misc.gml#L47)

##### type_of(variable)
value  
retruns: type of argument, as string  

## extension_object

### [object_destroy](/scripts/extension_object.gml#L5)

##### object_destroy(id)
results: destroys all instances of `id`. can be both object or instance  

## extension_real

### [real_within](/scripts/extension_real.gml#L5)

##### real_within(number, min, max)
params: real, real, real  
returns: true if number is withing range min/max (inclusive: min <= number <= max)  

### [real_within_exlusive](/scripts/extension_real.gml#L18)

##### real_within_exlusive(number, min, max)
params: real, real, real  
returns: true if number is withing range min/max (exclusive: min < number < max)  

### [real_is_integer](/scripts/extension_real.gml#L31)

##### real_is_integer(number)
params: real  
returns: true if `number` is integer (no decimals)  

### [real_is_natural](/scripts/extension_real.gml#L42)

##### real_is_natural(number)
params: real  
returns: true if number is natural number (integer and greater or equal to 0)  

## extension_string

### [string_text](/scripts/extension_string.gml#L5)

##### string_text(...)
params: value...  
returns: converts all arguments to string  

### [string_join](/scripts/extension_string.gml#L39)

##### string_join(array, joiner)
params: array, string  
returns: string with items in `array` joined by `joiner`  

