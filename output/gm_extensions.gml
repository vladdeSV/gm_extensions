#define gm_extensions
///Game Maker 1.4 Library Extensions



#define array_init
///array_init(height, length)
//params: real (natural), real (natural)
//retruns: array with `height` * `length` items
///array_init(length)
//params: real (natural)
//returns: array with `length` items
//note: alias for `array_create(length)`
///array_init()
//returns: empty array
//note: alias for `array_create(0)`

_gme_arguments(array_init, argument_count, 0, 1, 2);

var height = 1;
var length = 1;

if(argument_count == 0)
{
    return array_create(0);
}
else if(argument_count == 1)
{
    return array_create(argument[0]);
}
else if(argument_count == 2)
{
    height = argument[0];
    length = argument[1];
}

assert(real_is_natural(height) && height > 0, "array_init(...): `height` must be natural number greater than 0.");
assert(real_is_natural(length) && length > 0, "array_init(...): `length` must be natural number greater than 0.");

var array = 0;
for(var h = 0; h < height; ++h)
{
    array[h, length - 1] = 0;
}

return array;

#define array_of
///array_of(...)
//params: value...
//returns: creates an array from arguments

//array from arguments
var return_array = array_create(argument_count);;

//copy all arguments to array
for(var i = 0; i < argument_count; ++i)
{
    return_array[i] = argument[i];
}

return return_array;

#define array_slice
///array_slice(array, from, to)
//params: array (1D), real (natural), real (natural)
//retruns: portion of `array`. `from` (inclusive), `to` (exclusive)

var array = argument0;
var from = argument1;
var to = argument2;

assert(is_array(array) && array_is_1d(array), "array_slice(...): `array` must be 1D array.");
var length = array_length(array);

assert(real_is_natural(from) && real_is_natural(to), "array_slice(...): `from` and `to` must be natural numbers.");
assert(from <= to, string_text("array_slice(...): `from`/`to` missmatch. `from` must be less than or equal `to`. `from`: ", from, ", `to`: ", to, "."));
assert(from >= 0 && to <= length, string_text("array_slice(...): Out of bounds: [", from, " .. ", to, "], `array` is [0 .. ", length, "]."));

//if slice of length 0, return 0
if(from == to) return array_create(0);

var delta = to - from;
var return_array = array_create(0);

array_copy(return_array, 0, array, from, delta);

return return_array;

#define array_clone
///array_clone(array)
//params: array
//returns: deep copy of `array`, both 1D and 2D arrays

//store array pointer
var array = argument0;

assert(is_array(array), "array_clone(...): `array` must be array.");

var copy = 0;

//iterate over array height (height is 1 if array is 1D)
for(var i = 0; i < array_height_2d(array); ++i)
{
    //init the length of the array
    var length = array_length_2d(array, i);

    if(length)
    {
        copy[i, length - 1] = 0;

        //iterate over all items
        for(var j = 0; j < length; ++j)
        {
            //copy from `array` to `copy`
            copy[i,j] = array[@i,j];
        }
    }
}

return copy;

#define array_at
///array_at(array, index)
//params: array, real (natural)
//returns: element in `array` at `index` (`array[subindex, index]`)
///array_at(array, height, index)
//params: array, real (natural), real (natural)
//returns: element in `array` at `height, index` (`array[height, index]`)

_gme_arguments(array_at, argument_count, 2, 3);

if(argument_count == 2)
{
    var array = argument[0];
    var index = argument[1];

    assert(is_array(array), "array_at(...): `array` must be array.");
    assert(real_is_natural(index), "array_at(...): `index` must be natural number.");

    return array[@index];
}
else if(argument_count == 3)
{
    var array = argument[0];
    var height = argument[1];
    var index = argument[2];

    assert(is_array(array), "array_at(...): `array` must be array.");
    assert(real_is_natural(index), "array_at(...): `height` must be natural number.");
    assert(real_is_natural(index), "array_at(...): `index` must be natural number.");

    return array[@height, index];
}

#define array_append
///array_append(&array, value)
//params: array, value
//results: appends `value` to `array`
///array_append(&array, height, value)
//params: array, real (natural), value
//results: appends `value` to `array` at `height`

_gme_arguments(array_append, argument_count, 2, 3);

var array = 0;
var height = 0;
var value = 0;

if(argument_count == 2)
{
    array = argument[0];
    height = 0;
    value = argument[1];
}
else
{
    array = argument[0];
    height = argument[1];
    value = argument[2];
}

assert(is_array(array), "array_append(...): `array` must be array.")
assert(real_is_natural(height), "array_append(...): `height` must be natural number.");

array[@height, array_length(array, height)] = value;

return array;

#define array_split
///array_split(array, value)
//params: array (1D), value
//returns: 2D array, where each sub array was split by `value`

var array = argument0;
var value = argument1;

assert(is_array(array) && array_is_1d(array), "array_split(...): `array` must be 1D array.");

var height = 0;
var return_array = 0;

for(var i = 0; i < array_length(array); ++i)
{
    var item = array[i];

    if(item == value)
    {
        ++height;
    }
    else
    {
        return_array[height, array_length_2d(return_array, height)] = item;
    }
}

return return_array;

#define array_flat
///array_flat(array)
//params: array
//returns: 1D array from 2D array "flattened". `array_flat([[1,2,3], [4,5,6]]) == [1,2,3,4,5,6];`

var array = argument0;

assert(is_array(array), "array_flat(...): `array` must be array.");

var height = array_height_2d(array);
if(height < 2) return array;

var return_array = array_create(0);

for(var i = 0; i < height; ++i)
{
    //appends pointers to sub-arrays
    array_append(return_array, array_sub(array, i));
}

//return the content of all sub-array pointers
return array_expand(return_array);

#define array_sub
///array_sub(array, height)
//param: array, real (natural)
//retruns: 1D array from 2D array at position `height`

var array = argument0;
var height = argument1;

assert(is_array(array), "array_sub(...): `array` must be array.");
assert(real_is_natural(height), "array_sub(...): `height` must be natural number.");

var sub_array = array_create(0);

var length = array_length_2d(array, height);
var sub_array = array_create(length);

for(var n = 0; n < length; ++n)
{
    sub_array[n] = array[@height, n];
}

return sub_array;

#define array_reverse
///array_reverse(&array)
//params: array (1D)
//results: `array` with items in reverse order

var array = argument0;

assert(is_array(array) && array_is_1d(array), "array_reverse(...): `array` must be 1D array.");

var length = array_length(array);
for(var n = 0; n < floor(length/2); ++n)
{
    var temp = array[@n];
    array[@n] = array[@(length - 1 - n)];
    array[@(length - 1 - n)] = temp;
}

return array;

#define array_find
///array_find(array, value, [nth = 1])
//params: array (1D), real (natural), [real (natural)]
//returns: nth position where value is found in 1D array. if not found, returns -1

_gme_arguments(array_find, argument_count, 2, 3);

var array = argument[0];
var value = argument[1];
var nth = 1;

if(argument_count == 3)
{
    nth = argument[2];
}

assert(is_array(array) && array_is_1d(array), "array_find(...): `array` must be 1D array.");
assert(real_is_natural(nth) && nth > 0, "array_find(...): `nth` must be natural number greater than 0.");

var length = array_length_1d(array);
for(var n = 0; n < length; ++n)
{
    if(array[@n] == value && --nth == 0) return n;
}

return -1;


#define array_count
///array_count(array, value)
//params: array, value
//returns: count of how many of value exists in array

var array = argument0;
var value = argument1;

assert(is_array(array), "array_count(...): `array` must be array.");

var height = array_height_2d(array);
var count = 0;

for(var h = 0; h < height; ++h)
{
    var length = array_length_2d(array, h);
    for(var n = 0; n < length; ++n)
    {
        if(array[@h, n] == value) ++count;
    }
}

return count;

#define array_exists
///array_exists(array, value)
//params: array, value
//returns: count of how many of value exists in array

var array = argument0;
var value = argument1;

assert(is_array(array), "array_exists(...): `array` must be array.");

var height = array_height_2d(array);

for(var h = 0; h < height; ++h)
{
    var length = array_length_2d(array, h);
    for(var n = 0; n < length; ++n)
    {
        if(array[@h, n] == value) return true;
    }
}

return false;

#define array_expand
///array_expand(array)
//params: array (1D)
//results: `array` becomes all elements of nested arrays

var array = argument0;

assert(is_array(array) && array_is_1d(array), "array_expand(...): `array` must be 1D array.");

var al = array_length_1d(array);
if(al == 0) return array;

var return_array = array_create(0);
var offset = 0;

for(var i = 0; i < al; ++i)
{
    var arg = array[i];
    var pos = i + offset;

    if(is_array(arg))
    {
        var narr = array_expand(arg);
        var nl = array_length_1d(narr);

        for(var j = 0; j < nl; ++j)
        {
            return_array[pos + j] = narr[j];
        }

        offset += nl - 1;
    }
    else
    {
        return_array[pos] = arg;
    }
}

array_copy(array, 0, return_array, 0, array_length(return_array));

return array;

#define array_length
///array_length(array, [height = 0])
//params: array, [real (natural)]
//retruns: length of `array`, at height `height`

_gme_arguments(array_length, argument_count, 1, 2);

var array = argument[0];
var height = 0; if(argument_count == 2) height = argument[1];

assert(real_is_natural(height), "array_length(...): `height` must be natural number.");

return array_length_2d(array, height);

#define array_height
///array_height(array)
//params: array
//retruns: height of `array`
//note: alias of `array_height_2d(variable)`

var array = argument0;

assert(is_array(array), "array_height(...): `array` must be array.");

return array_height_2d(array);

#define array_insert
///array_insert(&array, index, value)
//params: array, real (natural), value
//results: `array` with `value` inserted at `array[index]`, pushing back all items one step
///array_insert(&array, height, index, value)
//params: array, real (natural), real (natural), value
//results: `array` with `value` inserted at `array[height, index]`, pushing back all items one step

_gme_arguments(array_insert, argument_count, 3, 4);

var array = argument[0];
var height = 0;
var index = 0;
var value = 0;

if(argument_count == 3)
{
    index = argument[1];
    value = argument[2];
}
else
{
    height = argument[1];
    index = argument[2];
    value = argument[3];
}

assert(is_array(array) && array_is_1d(array), "array_insert(...): `array` must be 1D array.");
assert(real_is_natural(height), "array_insert(...): `height` must be natural number.");
assert(real_is_natural(index), "array_insert(...): `index` must be natural number.");
var length = array_length(array);
assert(real_within(index, 0, length), "array_insert(...): `index` is out of bounds.");

var half_end = array_slice(array_sub(array, height), index, length);
if(is_array(half_end))
{
    //shift array one step left
    for(var i = length; i > index; --i)
    {
        array[@height, i] = array[@height, (i - 1)];
    }
}

array[@height, index] = value;

return array;


#define array_string
///array_string(string)
//params: string
//retruns: array with each all characters as items

var str = argument0;

assert(is_string(str), "array_string(...): `string` must be string.");

var str_length = string_length(str);
var return_array = array_create(str_length);

for(var i = 0; i < str_length; ++i)
{
    return_array[i] = string_char_at(str, i + 1);
}

return return_array;

#define array_sort
///array_sort(&array)
//params: array
//results: `array` sorted ascendingly. if sorting string: sorted alphabetically
//note: all items in `array` must be same type

var array = argument0;

assert(is_array(array) && array_is_1d(array), "array_sort(...): `array` must be 1D array.");

if(array_length_1d(array) == 0) return array;

//check array all same type
var array_type = type_of(array[0]);
var length = array_length(array);
for(var i = 0; i < length; ++i)
{
    assert(array_type == type_of(array[i]), string_text("array_sort(...): All types in array must be the same."));
}

//sorted array
var sorted = 0;

if(array_type == "string")
{
    //RADIX Sort ('string' Edition)
    sorted = _gme_string_sort(array, 0);
}
else
{
    //Quick Sort
    sorted = _gme_quick_sort(array);
}

//move item to original
array_copy(array, 0, sorted, 0, length);

return sorted;

#define array_replace
///array_replace(&array, index, value)
//params: array, real (natural), value
//results: `array[index]` replaced by `value`
///array_replace(&array, height, index, value)
//params: array, real (natural), real (natural), value
//results: `array[height, index]` replaced by `value`

_gme_arguments(array_replace, argument_count, 3, 4);

var array = argument[0];
var height = 0;
var index;
var value;

if(argument_count == 3)
{
    index = argument[1];
    value = argument[2];
}
else
{
    height = argument[1];
    index = argument[2];
    value = argument[3];
}

assert(is_array(array), "array_replace(...): `array` must be array.");
assert(real_is_natural(height), "array_replace(...): `height` must be natural number.");
assert(real_is_natural(index), "array_replace(...): `index` must be natural number.");

array[@height, index] = value;

return array;

#define array_swap_item
///array_swap_item(&array, index1, index2)
//params: array, real (natural), real (natural)
//results: modifies `array` by switching items at `index1` and `index2`
///array_swap_item(&array, height, index1, index2)
//params: array, real (natural), real (natural), real (natural)
//results: modifies `array` at `height` by switching items at `index1` and `index2`

_gme_arguments(array_swap_item, argument_count, 3, 4);

var array;
var height = 0;
var index1;
var index2;

if(argument_count == 3)
{
    array = argument[0];
    index1 = argument[1];
    index2 = argument[2];
}
else if(argument_count == 4)
{
    array = argument[0];
    height = argument[1];
    index1 = argument[2];
    index2 = argument[3];
}

assert(is_array(array), "array_swap(...): `array` must be array.");
assert(real_is_natural(height), "array_swap(...): `height` must be natural number.");
assert(real_is_natural(index1), "array_swap(...): `index1` must be natural number.");
assert(real_is_natural(index2), "array_swap(...): `index2` must be natural number.");

//if both indexes are the same, simply return
if(index1 == index2) return array;

var temp = array[@height, index2];
array[@height, index2] = array[@height, index1];
array[@height, index1] = temp;

return array;

#define array_is_1d
///array_is_1d(array)
//params: value
//retruns: true if `array` is array and has height of 1.

//array[0,n] == array[n]
return (array_height_2d(argument0) == 1 || (is_array(argument0) && array_height_2d(argument0) == 0));
#define array_filter
///array_filter(array, script)
//params: array (1D), script (script(val), returns bool)
//results: retruns array of items which validate to true when run with `script` (`script(array[n])`).

var array = argument0;
var script = argument1;

assert(is_array(array) && array_is_1d(array), "array_filter(...): `array` must be 1D array.");
assert(script_exists(script), "array_filter(...): `script` must be a script.");

var return_array = array_create(0);

for(var i = 0; i < array_length(array); ++i)
{
    var val = array[@i];

    if(script_execute(script, val) == true)
    {
        array_append(return_array, val);
    }
}

return return_array;
#define array_2d_of
///array_2d_of(...)
//params: array (1D)...
//results: makes 2d array of arrays.

var return_array = array_create(0);

//iterate all arguments
for(var h = 0; h < argument_count; ++h)
{
    var array = argument[h];
    
    assert(is_array(array) && array_is_1d(array), "array_2d_of(...): All arguments must be 1D arrays.");
    
    //clone array
    for(var j = 0; j < array_length_1d(array); ++j)
    {
        return_array[h, j] = array[j];
    }
}

return return_array;



#define ds_list_swap_item
///ds_list_swap_item(id, index_1, index_2)
//params: ds_list, real (natural), real (natural)
//results: swaps two elements, `index_1` and `index_2`, in a ds_list

var list = argument0;
var index_1 = argument1;
var index_2 = argument2;

//assert(is_ds_list(list), "ds_list_swap(...): `list` must be ds_list.");
assert(real_is_natural(index_1) && real_is_natural(index_2), "ds_list_swap(...): `index_1` and `index_2` must be natural numbers.");

var temp = ds_list_find_value(argument0, argument1);
ds_list_replace(argument0, argument1, ds_list_find_value(argument0, argument2));
ds_list_replace(argument0, argument2, temp);


#define log
///log(...)
//params: value...
//results: shorthand for `show_debug_message`

if(argument_count == 0)
{
    show_debug_message("");
    exit;
}

var array = 0;
for(var i = 0; i < argument_count; ++i)
{
    array[i] = argument[i];
}

show_debug_message(string_join(array));

#define assert
///assert(comparison, [message])
//params: real (boolean), [string]
//results: if `comparison` is false, show `message` and exit

//if arguments are not 1 or 2, exit.
if(!(1 <= argument_count && argument_count <= 2))
{
    show_error("ASSERTION ERROR: Wrong assertion argument count.", true);
}

//if `comparison` did not succeed
else if(argument[0] == false)
{
    //show `message`. if only one argument provided, show default message
    if(argument_count == 1)
    {
        show_error("Assertion failed!", true);
    }
    else
    {
        show_error("ASSERTION ERROR: " + argument[1], true);
    }
}

#define noop
///noop()
//results: nothing. noop is shorthand for "no operation"

#define type_of
///type_of(variable)
//params: value
//retruns: type of argument, as string

var variable = argument0;

if(is_array(variable))
{
    return "array";
}
else if(is_bool(variable))
{
    return "bool";
}
else if(is_int32(variable))
{
    return "int32";
}
else if(is_int64(variable))
{
    return "int64";
}
else if(is_matrix(variable))
{
    return "matrix";
}
else if(is_ptr(variable))
{
    return "ptr";
}
else if(is_real(variable))
{
    return "real";
}
else if(is_string(variable))
{
    return "string";
}
else if(is_undefined(variable))
{
    return "undefined";
}
else if(is_vec3(variable))
{
    return "vec3";
}
else if(is_vec4(variable))
{
    return "vec4";
}
else if(ds_exists(variable, ds_type_map))
{
    return "ds_type_map";
}
else if(ds_exists(variable, ds_type_list))
{
    return "ds_type_list";
}
else if(ds_exists(variable, ds_type_stack))
{
    return "ds_type_stack";
}
else if(ds_exists(variable, ds_type_grid))
{
    return "ds_type_grid";
}
else if(ds_exists(variable, ds_type_queue))
{
    return "ds_type_queue";
}
else if(ds_exists(variable, ds_type_priority))
{
    return "ds_type_priority";
}

return "unknown";
#define ternary
///ternary(comparison, true_value, false_value)
//params: real (bool), value, value
//returns: if `comparison` is true, `true_value`, else `false_value`

var comparison = argument0;
var true_value = argument1;
var false_value = argument2;
assert(is_bool(comparison) || real_is_integer(comparison), "ternary(...): `comparison` must be a convertable to boolean.");

if(comparison)
{
    return true_value;
}
else
{
    return false_value;
}



#define real_within
///real_within(number, min, max)
//params: real, real, real
//returns: true if number is withing range min/max (inclusive: min <= number <= max)

var number = argument0;
var minimum = argument1;
var maximum = argument2;

assert(is_real(number) && is_real(minimum) && is_real(maximum), "`number`, `minimum`, and `maximum` must be numbers.");

return ((minimum <= number) && (number <= maximum));

#define real_within_exclusive
///real_within_exclusive(number, min, max)
//params: real, real, real
//returns: true if number is withing range min/max (exclusive: min < number < max)

var number = argument0;
var minimum = argument1;
var maximum = argument2;

assert(is_real(number) && is_real(minimum) && is_real(maximum), "`number`, `minimum`, and `maximum` must be numbers.");

return ((minimum < number) && (number < maximum));

#define real_is_integer
///real_is_integer(number)
//params: real
//returns: true if `number` is integer (no decimals)

var number = argument0;

return (is_real(number) && (number mod 1) == 0);

#define real_is_natural
///real_is_natural(number)
//params: real
//returns: true if number is natural number (integer and greater or equal to 0)

var number = argument0;

return (real_is_integer(number) && number >= 0);


#define string_text
///string_text(...)
//params: value...
//returns: converts all arguments to string

//return value
var text = "";

//iterate and append all arguments
for(var n = 0; n < argument_count; ++n)
{
    var current_argument = argument[n];

    //if current argument is...

    //string
    if(is_string(current_argument))
    {
        text += current_argument;
    }
    //1D array
    else if(is_array(current_argument) && array_height_2d(current_argument) == 1)
    {
        text += "[" + string_join(current_argument, ", ") + "]";
    }
    //other
    else
    {
        text += string(current_argument);
    }
}

return text;

#define string_join
///string_join(array, [joiner = ""])
//params: array, [string]
//returns: string with items in `array` joined by `joiner`

_gme_arguments(string_join, argument_count, 1, 2);

var array = argument[0];
var joiner = ""; if(argument_count == 2) joiner = argument[1];

assert(is_array(array) && array_is_1d(array), "string_join(...): `array` must be 1D array.");
assert(is_string(joiner), "string_join(...): `joiner` must be string.");

var length = array_length_1d(array);
var joined = "";

for(var n = 0; n < length; ++n)
{
    if(n != 0) joined += joiner;
    joined += string(array[@n]);
}

return joined;

#define string_split
///string_split(string, separator)
//params: string, string
//returns: array of strings (`string_split("one,2,five", ",") == ["one", "2", "five"]`)
//note: automatically converts parameters to strings. `string_split(123456, 4) == ["123", "56"]`

//convert arguments to strings
var source = string(argument0);
var separator = string(argument1);

//initialize array
var splits = array_create(0); //(string_count(separator, source));
//get first occurance position in string. (will be 0 (false) if not found)
var next_find = string_pos(separator, source);

//while `next_find` isn't 0
while(next_find)
{
    //add from start of string to where separator is found to return array
    array_append(splits, string_slice(source, 1, next_find));
    //trim away
    source = string_slice(source, next_find + string_length(separator), string_length(source) + 1);
    next_find = string_pos(separator, source);
}

array_append(splits, source);

return splits;

#define string_slice
///string_slice(string, from, to)
//params: string, real (natural), real (natural)
//retruns: portion of `string`. `from` (inclusive), `to` (exclusive).

var source = argument0;
var from = argument1;
var to = argument2;

assert(is_string(source), "string_slice(...): `string` must be string.");
var length = string_length(source);

assert(real_is_natural(from) && real_is_natural(to), "string_slice(...): `from` and `to` must be natural numbers.");
assert(from <= to, string_text("string_slice(...): `from`/`to` missmatch. `from` must be less than or equal `to`. `from`: ", from, ", `to`: ", to, "."));
assert(from > 0 && to <= length + 1, string_text("string_slice(...): Out of bounds: [", from, " .. ", to, "], `string` is [1 .. ", length + 1, "]."));

return string_copy(source, from, to - from);;

#define string_substring
///string_substring(string, from, length)
//params: string, real (natural), real (natural)
//returns: string from index `from` to `from + length`. `string_substring("hello world!", 6, 3) == "wor")`.
//note: alias for `string_copy(...)`.

var source = argument0;
var from = argument1;
var length = argument2;

assert(is_string(source), "string_substring(...): `string` must be string.");
assert(real_is_natural(from), "string_substring(...): `from` must be natural number.");
assert(real_is_natural(length), "string_substring(...): `length` must be natural number.");
assert((from + length <= string_length(source)), "string_substring(...): `from+length` must be less or equal to `string` length.");

return string_copy(source, from, length);

#define string_find
///string_find(source, find, [nth = 1])
//params: string, string, [real (natural)]
//returns: position of `nth` occurence of `find` in `source`. if not found, returns 0

_gme_arguments(string_find, argument_count, 2, 3);

var source = argument[0];
var find = argument[1];
var nth = 1; if(argument_count == 3) nth = argument[2];

assert(is_string(source), "string_find(...): `string` must be string.");
assert(is_string(find), "string_find(...): `find` must be string.");
assert(real_is_natural(nth) && nth > 0, "string_find(...): `nth` must be natural number greater than 0.");

var offset = 0;

while(--nth)
{
    var d = string_pos(find, source);
    offset += d + string_length(find) - 1;
    source = string_slice(source, d + string_length(find), string_length(source));
}

var ret = string_pos(find, source);
return ternary(ret, ret + offset, 0);
#define _gme


#define _gme_arguments
///_gme_arguments(script, argument_count, count1, count2, counts...)
//params: script, real (natural), real(natural), real(natural), real(natural)...

if(argument_count < 4) assert(0, "_gme_arguments(...): Incorrect argument count: expected 4 or more, got " + string(argument_count) + ".");

var script = argument[0];
var arg_count = argument[1];

var l = argument_count - 2;
var str = "";

for(var i = 0; i < l; ++i)
{
    var c = argument[2 + i];
    if(arg_count == c)
    {
        exit;
    }

    if(i != l - 1)
    {
        str += string(c) + ",";
    }
    else
    {
        str += " or " + string(c);
    }
}

assert(0, string(script_get_name(script)) + "(...): Incorrect argument count. Expected: " + str + ", got " + string(argument_count) + ".");
#define _gme_quick_sort
///_gme_quick_sort(array)
//params: array (1D of real)
//returns: array of reals sorted

var array = argument0;
var length = array_length(array);

if(length == 0 || length == 1)
{
    return array;
}
else if(length == 2)
{
    var a = array[0];
    var b = array[1];
    if(a < b)
    {
        return array_of(a, b);
    }
    else
    {
        return array_of(b, a);
    }
}
else
{

    var pivot = array[0];
    
    var smaller = array_create(0);
    var same    = array_of(pivot);
    var bigger  = array_create(0);
    
    for(var i = 1; i < length; ++i)
    {
        var item = array[i];
        
        if(item < pivot)
        {
            array_append(smaller, item);
        }
        else if(item == pivot)
        {
            array_append(same, item);
        }
        else
        {
            array_append(bigger, item);
        }
    }
    
    smaller = _gme_quick_sort(smaller);
    bigger  = _gme_quick_sort(bigger);
    
    return array_expand(array_of(smaller, same, bigger));
}

#define _gme_string_sort
///_gme_string_sort(array, sorting_by_nth_character)
//params: array (1D of string)
//returns: array of strings sorted

var array = argument0;
var nth = argument1;

var bucket = 0;
var max_length = 0;

for(var i = 0; i < array_length_1d(array); ++i)
{
    var item = array[i];
    
    //keep track of maxumum length
    max_length = max(max_length, string_length(item));
    var byte = string_byte_at(item, nth + 1);
    
    bucket[byte, array_length_2d(bucket, byte)] = item;

}

var return_array = array_create(0);

for(var i = 0; i < array_height_2d(bucket); ++i)
{
    var blen = array_length_2d(bucket, i);
    if(array_length_2d(bucket, i))
    {
        var temp_array = 0;
        
        if(nth <= max_length && blen > 1)
        {
            var ns = array_sub(bucket, i);
            temp_array = _gme_string_sort(ns, nth + 1);
        }
        else
        {
            temp_array = array_sub(bucket, i);
        }
        
        //sort arrays based on length
        
        var strings_sorted_by_length_array = 0;
        for(var j = 0; j < array_length_1d(temp_array); ++j)
        {
            var item = temp_array[j];
            strings_sorted_by_length_array[string_length(item), array_length_2d(strings_sorted_by_length_array, string_length(item))] = item;
        }
        
        var n = 0;
        for(var yy = 0; yy < array_height_2d(strings_sorted_by_length_array); ++yy)
        {
            var l = array_length_2d(strings_sorted_by_length_array, yy);
            if(l > 0)
            {
                for(var xx = 0; xx < l; ++xx)
                {
                    temp_array[n] =
                    strings_sorted_by_length_array
                    [
                        yy,
                        xx
                    ];
                    ++n;
                }
            }
        }
        
        for(var j = 0; j < array_length_1d(temp_array); ++j)
        {
            return_array[array_length_1d(return_array)] = temp_array[j];
        }
    }
}

return return_array;
///unittests
//if-syntax is used to categorize tests
var unittest = true;

///array_init
if(unittest)
{
    var array_empty = array_init();
    assert(array_is_1d(array_empty));
    assert(array_length_1d(array_empty) == 0);

    var array_1d = array_init(2);
    assert(array_1d[0] == 0);
    assert(array_1d[1] == 0);
    assert(array_length_1d(array_1d) == 2);

    var array_2d = array_init(4, 2);
    assert(array_2d[0,0] == 0);
    assert(array_2d[1,1] == 0);
    assert(array_2d[3,1] == 0);
    assert(array_height_2d(array_2d) == 4);
    assert(array_length_2d(array_2d, 0) == 2);
}

///array_of
if(unittest)
{
    var array = array_of(0, 1, "two", 3, 4);
    assert(array[3] == 3);
    assert(array[2] == "two");
}

//array_at
if(unittest)
{
    var array_1d = 0;
    array_1d[2] = 42;
    assert(array_at(array_1d, 0) == 0);
    assert(array_at(array_1d, 2) == 42);

    var array_2d = 0;
    array_2d[4, 2] = 3;
    assert(array_at(array_2d, 4, 2) == 3);
}

///array_slice
if(unittest)
{
    var array_1d = array_of(0,1,2,3,4,5,6,7);

    assert(array_equals(array_slice(array_1d, 0, 3), array_of(0,1,2)));
    assert(array_equals(array_slice(array_1d, 5, 8), array_of(5,6,7)));
    assert(array_equals(array_slice(array_1d, 2, 2), array_of()));

    array_1d = array_of("car", "house", 3, "fire");

    assert(array_equals(array_slice(array_1d, 1, 2), array_of("house")));
    assert(array_equals(array_slice(array_1d, 0, 3), array_of("car", "house", 3)));
}

///array_clone
if(unittest)
{
    //copy 1D arrays
    var array_1d = 0;
        array_1d[0] = 42;

    var new_array_1d = array_clone(array_1d);
        new_array_1d[0] = 3;

    assert(new_array_1d[0] != array_1d[0]);
    assert(array_1d[0] == 42);

    //copy 2D arrays
    var array_2d = 0;
        array_2d[4, 2] = 6;
    var new_array_2d = array_clone(array_2d);
        new_array_2d[4, 2] = 5;

    assert(    array_2d[4, 2] == 6);
    assert(new_array_2d[4, 2] != 6);
    assert(new_array_2d[4, 2] == 5);
}

///array_at
if(unittest)
{
    var array_1d = array_of("banana", "apple", "lemon");
    assert(array_at(array_1d, 0) == "banana");
    assert(array_at(array_1d, 0) == array_1d[0]);
    assert(array_at(array_1d, 2) == "lemon");

    var array_2d = array_init();
    array_2d[0, 0] = "00";
    array_2d[0, 1] = "01";
    array_2d[1, 0] = "10";
    array_2d[1, 1] = "11";
    array_2d[1, 2] = "12";

    assert(array_at(array_2d,    1) == "01");
    assert(array_at(array_2d, 0, 1) == "01");
    assert(array_at(array_2d, 1, 0) == "10");
    assert(array_at(array_2d, 1, 2) == "12");
}


///array_append
if(unittest)
{
    var array_1d = array_init();
    array_append(array_1d, 2);
    assert(array_equals(array_1d, array_of(2)));
}

///array_split
if(unittest)
{
    var array = array_of(1, 2, 3, 4, 5, 6);
    var splitted_array = array_split(array, 4);

    assert(array_equals(array_sub(splitted_array, 0), array_of(1, 2, 3)));
    assert(array_equals(array_sub(splitted_array, 1), array_of(5, 6)));
}

///array_flat
if(unittest)
{
    var array = 0;
    array[0,0] = 1;
    array[0,1] = 2;
    array[1,0] = "at position 1,0";
    array[1,1] = 3;

    assert(array_equals(array_flat(array), array_of(1, 2, "at position 1,0", 3)));
}

///array_sub
if(unittest)
{
    var array_2d = array_init(3,2);
    array_2d[0,0] = "hello"; array_2d[0,1] = "world"; array_2d[0,2] = "!!!";
    array_2d[1,0] = 1; array_2d[1,1] = 2; array_2d[1,2] = 3;

    assert(array_equals(array_sub(array_2d, 0), array_of("hello", "world", "!!!")));
    assert(array_equals(array_sub(array_2d, 1), array_of(1, 2, 3)));
}

///array_reverse
if(unittest)
{
    var array_1d = array_of(1,2,3,4);
    //array_reversed modifies original array.
    var array_1d_reversed = array_reverse(array_1d);
    assert(array_equals(array_1d_reversed, array_of(4,3,2,1)));
}

///array_find
if(unittest)
{
    //find first value
    var array_1d = array_of(1,2,3,4);
    assert(array_find(array_1d, 3) == 2);
    assert(array_find(array_1d, 16) == -1);

    //find 2nd value
    array_1d = array_of("number", "", "", "number");
    assert(array_find(array_1d, "number", 2) != 0);
    assert(array_find(array_1d, "number", 2) == 3);
}

///array_count
if(unittest)
{
    var array_1d = array_of(1,4,1,1,"tree");
    assert(array_count(array_1d, 1) == 3);
    assert(array_count(array_1d, 4) == 1);
    assert(array_count(array_1d, "car") == 0);
}

///array_exists
if(unittest)
{
    var array_1d = array_of(1,2,3,4,5);
    assert(array_exists(array_1d, 1) == true);
    assert(array_exists(array_1d, 6) == false);
    assert(array_exists(array_1d, "tree") == false);
}

///array_expand
if(unittest)
{
    var a1 = array_of("abs","dps","fps");
    var a2 = array_of(3, 4, 5);
    var a3 = array_of(a1, array_of(), a2);
    var a4 = array_of("tree", a3);
    var a5 = array_of("ball", a4, "house");

    //nested arrays
    var expanded_array = array_expand(a3);
    assert(array_equals(expanded_array, array_of("abs","dps","fps",3,4,5)));

    //multiple layers of arrays nested
    expanded_array = array_expand(a5);
    assert(array_equals(expanded_array, array_of("ball","tree","abs","dps","fps",3,4,5,"house")));

    //level limit
    expanded_array = array_expand(a5);

    //no expansion
    var array = array_of("test");
    assert(array_equals(array_expand(array), array));
}

///array_length
if(unittest)
{
    var array_1d = array_of(42,134,"house");
    assert(array_length(array_1d) == 3);

    var array_2d = 0;
    array_2d[0,3] = 0;
    array_2d[1,2] = 0;
    assert(array_length(array_2d)    == 4);
    assert(array_length(array_2d, 0) == 4);
    assert(array_length(array_2d, 1) == 3);
}

///array_height
if(unittest)
{
    var array_2d = array_init(2, 7);
    assert(array_height(array_2d) = 2);
}

///array_insert
if(unittest)
{
    var array_1d = array_of(1,2,3,5);
    array_1d = array_insert(array_1d, 3, 4);
    assert(array_equals(array_1d, array_of(1,2,3,4,5)));

    array_1d = array_of("house", "ball", "car");
    array_insert(array_1d, 0, "number");
    assert(array_equals(array_1d, array_of("number","house","ball","car")));
}

///array_string
if(unittest)
{
    var str = "12345";
    var array = array_string(str);
    assert(string_length(str) == array_length(array));
    assert(array_equals(array, array_of("1", "2", "3", "4", "5")));
}

///array_sort
if(unittest)
{
    var array = array_of(2,5,4,100,1,3,5,8);
    array_sort(array);
    assert(array_equals(array, array_of(1,2,3,4,5,5,8,100)));

    array = array_of("banana", "abs", "coconut", "apple", "asteroid");
    assert(array_equals(array_sort(array), array_of("abs", "apple", "asteroid", "banana", "coconut")));
}

///array_replace
if(unittest)
{
    var array = array_of("banana", "pineapple", "lumberjack");
    array = array_replace(array, 1, 42);
    assert(array_equals(array, array_of("banana", 42, "lumberjack")));

    array = array_of("one", "two", "three");
    array_replace(array, 2, 3);
    assert(array_equals(array, array_of("one", "two", 3)));
}

///array_swap_item
if(unittest)
{
    var array_1d = array_of(0,1,2,3,4,5);
    array_swap_item(array_1d, 0, 3);
    assert(array_equals(array_1d, array_of(3,1,2,0,4,5)));

    var array_1d = array_of("zeroeth", "first", "second", "third", "fourth");
    array_swap_item(array_1d, 2, 4);
    assert(array_equals(array_1d, array_of("zeroeth", "first", "fourth", "third", "second")));
}

///array_is_1d
if(unittest)
{
    var array = array_init(4);
    assert(array_is_1d(array));

    array = array_init(3, 2);
    assert(!array_is_1d(array));

    array = array_init(1, 5);
    assert(array_is_1d(array));
}

///array_filter
if(unittest)
{
    var array = array_of(1, 2, 3.14, "four", -42, 666);
    var natural = array_filter(array, real_is_natural);
    
    assert(array_equals(natural, array_of(1, 2, 666)));
}

///array_2d_of
if(unittest)
{
    var array_2d = array_2d_of(array_of("apple", "banana", "clementine"), array_of(42), array_of("car"));
    
    var array_2d_2 = array_create(0);
    array_2d_2[0, 0] = "apple";
    array_2d_2[0, 1] = "banana";
    array_2d_2[0, 2] = "clementine";
    array_2d_2[1, 0] = 42;
    array_2d_2[2, 0] = "car";
    
    assert(array_equals(array_2d, array_2d_2));
    assert(array_height_2d(array_2d) == 3);
    
    assert(array_equals(array_2d_of(), array_create(0)));
}

///real_within
if(unittest)
{
    assert( real_within(7,    5, 10));
    assert( real_within(8.65, 5, 10));
    assert( real_within(5,    5, 10));
    assert( real_within(10,   5, 10));
    assert(!real_within(15,   5, 10));
    assert(!real_within(3,    5, 10));
}

///real_within_exclusive
if(unittest)
{
    assert( real_within_exclusive(7,    5, 10));
    assert( real_within_exclusive(8.65, 5, 10));
    assert(!real_within_exclusive(5,    5, 10));
    assert(!real_within_exclusive(10,   5, 10));
    assert(!real_within_exclusive(15,   5, 10));
    assert(!real_within_exclusive(3,    5, 10));
}

///real_is_integer
if(unittest)
{
    assert( real_is_integer(-4));
    assert( real_is_integer(0));
    assert( real_is_integer(3));
    assert(!real_is_integer(1.25));
    assert(!real_is_integer("five"));
    assert(!real_is_integer(array_of(3, "mud")));
}

///real_is_natural
if(unittest)
{
    assert(!real_is_natural(-4));
    assert( real_is_natural(0));
    assert( real_is_natural(3));
    assert(!real_is_natural(1.25));
}

///string_text
if(unittest)
{
    assert(string_text("hello ", 42, " number") == "hello 42 number");
    assert(string_text("an array: ", array_of(1,"two",3)) == "an array: [1, two, 3]");
}

///string_join
if(unittest)
{
    assert(string_join(array_of(4,"three",2,1))       == "4three21");
    assert(string_join(array_of(4,"three",2,1), ", ") == "4, three, 2, 1");
    assert(string_join(array_of("old","folks","home"), " ~ ") == "old ~ folks ~ home");
}

///string_split
if(unittest)
{
    var splits = string_split("hello--world--again12", "--");
    assert(splits[0] = "hello");
    assert(splits[1] = "world");
    assert(splits[2] = "again12");

    splits = string_split(123456, 4);
    assert(splits[0] == "123");
    assert(splits[1] == "56");
}

///string_slice
if(unittest)
{
    var str = "HelloYellow!";
    assert(string_slice(str, 1, 6) == "Hello");
    assert(string_slice(str, 2, 6) == "ello");
    assert(string_slice(str, 2, 8) == "elloYe");

    assert(string_slice(str, 2, 3) == "e");
    assert(string_slice(str, 2, 2) == "");
}

///string_substring
if(unittest)
{
    var str = "fire water burn";
    assert(string_substring(str, 1, 4) == "fire");
    assert(string_substring(str, 6, 4) == "wate");
    assert(string_substring(str, 7, 0) == "");
}

///string_find
if(unittest)
{
    var str = "123456789";
    assert(string_find(str, "4"));
    assert(string_find(str, "4") == 4);
    assert(string_find(str, "6789") == 6);
    assert(string_find(str, "ABC") == 0);

    str = "hello world hello earth hello house";
    assert(string_find(str, "hello", 1) == 1);
    assert(string_find(str, "hello", 2) == 13);
    assert(string_find(str, "hello", 3) == 25);
    assert(string_find(str, "hello", 4) == 0);

    str = "the roof the roof is on fire";
    assert(string_find(str, "roof", 1) == 5);
    assert(string_find(str, "roof", 2) == 14);
}

///ds_list_swap_item
if(unittest)
{
    list = ds_list_create();
    ds_list_add(list, 400, "test");
    
    ds_list_swap_item(list, 0, 1);
    assert(ds_list_find_value(list, 0) == "test");
    assert(ds_list_find_value(list, 1) == 400);
    
    ds_list_destroy(list);
}

//*/

game_end();

