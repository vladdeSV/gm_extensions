# GameMaker 1.4 Library Extensions Reference
## Reference

### extension_array

1. [array_init](#array_init)
1. [array_of](#array_of)
1. [array_slice](#array_slice)
1. [array_clone](#array_clone)
1. [array_at](#array_at)
1. [array_append](#array_append)
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
1. [array_replace](#array_replace)
1. [array_swap_item](#array_swap_item)
1. [array_is_1d](#array_is_1d)

### extension_ds_list

1. [ds_list_swap_item](#ds_list_swap_item)

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

## extension_array

### [array_init](/scripts/extension_array.gml#L4)

##### array_init()
returns: empty array  

##### array_init(length)
params: real (natural)  
returns: array with `length` items  
note: alias for `array_create`  

##### array_init(height, length)
params: real (natural), real (natural)  
retruns: array with `height` * `length` items  

### [array_of](/scripts/extension_array.gml#L45)

##### array_cof(arg, ...)
params: value, value...  
returns: creates an array from arguments  

### [array_slice](/scripts/extension_array.gml#L61)

##### array_slice(array, from, to)
params: array, real (natural), real (natural)  
retruns: portion of `array`. `from` (inclusive), `to` (exclusive). if `from` == `to`, returns 0  

### [array_clone](/scripts/extension_array.gml#L88)

##### array_clone(array)
params: array  
returns: deep copy of `array`, both 1D and 2D arrays  

### [array_at](/scripts/extension_array.gml#L121)

##### array_at(array, index)
params: array, real (natural)  
returns: element in `array` at `index` (`array[subindex, index]`)  

##### array_at(array, height, index)
params: array, real (natural), real (natural)  
returns: element in `array` at `height, index` (`array[height, index]`)  

### [array_append](/scripts/extension_array.gml#L154)

##### array_append(array, value)
params: array, value  
results: appends `value` to `array`  
note: if `value` is not array, cannot edit by reference. must assign returned array  

##### array_append(array, height, value)
params: array, real (natural), value  
results: appends `value` to `array` at `height`  
note: if `value` is not array, cannot edit by reference. must assign returned array  

### [array_split](/scripts/extension_array.gml#L193)

##### array_split(string, separator)
params: string, string  
returns: array of strings (`array_split("one,2,five", ",") == ["one", "2", "five"]`)  

### [array_sub](/scripts/extension_array.gml#L232)

##### array_sub(array, height)
param: array, real (natural)  
retruns: 1D array from 2D array at position `height`  

### [array_reverse](/scripts/extension_array.gml#L255)

##### array_reverse(array)
params: array (1D)  
results: `array` with items in reverse order  

### [array_find](/scripts/extension_array.gml#L274)

##### array_find(array, value, [nth = 1])
params: array (1D), real (natural), [real (natural)]  
returns: nth position where value is found in 1D array. if not found, returns -1  

### [array_count](/scripts/extension_array.gml#L302)

##### array_count(array, value)
params: array, value  
returns: count of how many of value exists in array  

### [array_exists](/scripts/extension_array.gml#L327)

##### array_exists(array, value)
params: array, value  
returns: count of how many of value exists in array  

### [array_expand](/scripts/extension_array.gml#L350)

##### array_expand(array)
params: array (1D)  
results: `array` becomes all elements of nested arrays  

### [array_length](/scripts/extension_array.gml#L393)

##### array_length(array, [height = 0])
params: array, [real (natural)]  
retruns: length of `array`, at height `height`  

### [array_height](/scripts/extension_array.gml#L407)

##### array_height(array)
params: value  
retruns: height of `array`  

### [array_insert](/scripts/extension_array.gml#L414)

##### array_insert(array, index, value)
params: array, real (natural), value  
results: `array` with `value` inserted at `array[index]`, pushing back all items one step  

##### array_insert(array, height, index, value)
params: array, real (natural), real (natural), value  
results: `array` with `value` inserted at `array[height, index]`, pushing back all items one step  

### [array_string](/scripts/extension_array.gml#L462)

##### array_string(string)
params: string  
retruns: array with each element in array as a character  

### [array_sort](/scripts/extension_array.gml#L481)

##### array_sort(array, [ascending = true])
params: array, [real (bool)]  
results: `array` sorted. if sorting string: sorted alphabetically  
note: all items in `array` must be same type  

### [array_replace](/scripts/extension_array.gml#L533)

##### array_replace(array, index, value)
params: array, real (natural), value  
results: `array[index]` replaced by `value`  

##### array_replace(array, height, index, value)
params: array, real (natural), real (natural), value  
results: `array[height, index]` replaced by `value`  

### [array_swap_item](/scripts/extension_array.gml#L568)

##### array_swap_item(array, index1, index2)
params: array, real (natural), real (natural)  
results: modifies `array` by switching items at `index1` and `index2`  

##### array_swap_item(array, height, index1, index2)
params: array, real (natural), real (natural), real (natural)  
results: modifies `array` at `height` by switching items at `index1` and `index2`  

### [array_is_1d](/scripts/extension_array.gml#L608)

##### array_is_1d(array)
params: value  
retruns: true if `array` is array and has height == 1.  

## extension_ds_list

### [ds_list_swap_item](/scripts/extension_ds_list.gml#L4)

##### ds_list_swap_item(id, index_1, index_2)
params: ds_list, real (natural), real (natural)  
results: swaps two elements, `index_1` and `index_2`, in a ds_list  

## extension_misc

### [log](/scripts/extension_misc.gml#L4)

##### log(...)
params: value...  
results: shorthand for `show_debug_message`  

### [assert](/scripts/extension_misc.gml#L23)

##### assert(comparison, [message])
params: real (boolean), string  
results: if `comparison` is false, show `message` and exit  

### [noop](/scripts/extension_misc.gml#L48)

##### noop()
results: nothing. noop is shorthand for "no operation"  

### [type_of](/scripts/extension_misc.gml#L52)

##### type_of(variable)
params: value  
retruns: type of argument, as string  

## extension_object

### [object_destroy](/scripts/extension_object.gml#L4)

##### object_destroy(id)
results: destroys all instances of `id`. can be both object or instance  

## extension_real

### [real_within](/scripts/extension_real.gml#L4)

##### real_within(number, min, max)
params: real, real, real  
returns: true if number is withing range min/max (inclusive: min <= number <= max)  

### [real_within_exlusive](/scripts/extension_real.gml#L17)

##### real_within_exlusive(number, min, max)
params: real, real, real  
returns: true if number is withing range min/max (exclusive: min < number < max)  

### [real_is_integer](/scripts/extension_real.gml#L30)

##### real_is_integer(number)
params: real  
returns: true if `number` is integer (no decimals)  

### [real_is_natural](/scripts/extension_real.gml#L41)

##### real_is_natural(number)
params: real  
returns: true if number is natural number (integer and greater or equal to 0)  

## extension_string

### [string_text](/scripts/extension_string.gml#L4)

##### string_text(...)
params: value...  
returns: converts all arguments to string  

### [string_join](/scripts/extension_string.gml#L38)

##### string_join(array, joiner)
params: array, string  
returns: string with items in `array` joined by `joiner`  

