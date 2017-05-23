#define extension_array


#define array_init
///array_init(length)
//params: real (natural)
//returns: array with `length` items
///array_init(height, length)
//params: real (natural), real (natural)
//retruns: array with `height` * `length` items

_gme_arguments(array_init, argument_count, 1, 2);

var height = 1;
var length = 1;

if(argument_count == 1)
{
    length = argument[0];
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

#define array_create
///array_create(arg, ...)
//params: value, value...
//returns: creates an array from arguments

//array from arguments
var return_array = array_init(argument_count);;

//copy all arguments to array
for(var i = 0; i < argument_count; ++i)
{
    return_array[i] = argument[i];
}

return return_array;

#define array_slice
///array_slice(array, from, to)
//params: array, real (natural), real (natural)
//retruns: portion of `array`. `from` (inclusive), `to` (exclusive). if `from` == `to`, returns 0

var array = argument0;
var from = argument1;
var to = argument2;

assert(is_array(array) && array_is_1d(array), "array_slice(...): `array` must be 1D array.");
var length = array_length(array);

assert(real_is_natural(from) && real_is_natural(to), "array_slice(...): `from` and `to` must be natural numbers.");
assert(from <= to, string_text("array_slice(...): `from`/`to` missmatch. `from` must be less than or equal `to`. `from`: ", from, ", `to`: ", to, "."));
assert(from >= 0 && to <= length, string_text("array_slice(...): Out of bounds: [", from, " .. ", to, "], `array` is [0 .. ", length, "]."));

//if slice of length 0, return 0
if(from == to) return 0;

var return_array = array_init(to - from);
for(var i = from; i < to; ++i)
{
    return_array[i - from] = array[@i];
}

return return_array;

#define array_copy
///array_copy(array)
//params: array
//returns: deep copy of `array`, both 1D and 2D arrays

//store array pointer
var array = argument0;

assert(is_array(array), "array_copy(...): `array` must be array.");

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
///array_append(array, value)
//params: array, value
//results: appends `value` to `array`
//note: if `value` is not array, cannot edit by reference. must assign returned array
///array_append(array, height, value)
//params: array, real (natural), value
//results: appends `value` to `array` at `height`
//note: if `value` is not array, cannot edit by reference. must assign returned array

_gme_arguments(array_append, argument_count, 2, 3);

if(argument_count == 2)
{
    var array = argument[0];
    var height = 0;
    var value = argument[1];
}
else if(argument_count == 3)
{
    var array = argument[0];
    var height = argument[1];
    var value = argument[2];
}

assert(real_is_natural(height), "array_append(...): `height` must be natural number.");
var length = array_length(array, height);

if(!is_array(array))
{
    array[height, 0] = value;
}
else
{
    array[@height, length] = value;    
}

return array;

#define array_equal
///array_equal(array1, array2)
//params: array, array
//returns: true if the content of `array1` and `array2` are equal

var array1 = argument0;
var array2 = argument1;

assert(is_array(array1) && is_array(array2), "array_equal(...): `array1` and `array2` must be arrays.");

//if the heights are different, they are not equal
if(array_height_2d(array1) != array_height_2d(array2)) return false;

//store the height of both arrays (array1 length == array2 length)
var height = array_height_2d(array1);

//check lengths of all subarrays
for(var h = 0; h < height; ++h)
{
    //if lengths of arrays are different, they are not equal
    if(array_length_2d(array1, h) != array_length_2d(array2, h)) return false;
}

//check the contents of all arrays
for(var h = 0; h < height; ++h)
{
    //store both subarrays length
    var length = array_length_2d(array1, h);
    
    for(var l = 0; l < length; ++l)
    {
        //if content not equal, return false
        if(array1[@h, l] != array2[@h, l]) return false;
    }
}

return true;

#define array_split
///array_split(string, separator)
//params: string, string
//returns: array of strings (`array_split("one,2,five", ",") == ["one", "2", "five"]`)

//todo: split arrays with value
//eg. array_split([1,2,3,4,5], 3) == [[1,2],[4,5]])

//convert arguments to strings
var source = string(argument0);
var separator = string(argument1);

//initialize array
var splits = array_init(string_count(separator, source));
var splits_position = 0;

//temporary split
var split = "";
//store source string length
var source_length = string_length(source);

//iterate over all characters in string
for(var i = 1; i <= source_length + 1; ++i)
{
    var c = string_char_at(source, i);
    if(c == separator || c == "")
    {
        splits[splits_position] = split;
        split = "";
        ++splits_position;
    }
    else
    {
        split += c;
    }
}

return splits;

#define array_sub
///array_sub(array, height)
//param: array, real (natural)
//retruns: 1D array from 2D array at position `height`

var array = argument0;
var height = argument1;

assert(is_array(array), "array_sub(...): `array` must be array.");
assert(real_is_natural(height), "array_sub(...): `height` must be natural number.");

var length = array_length_2d(array, height);
var sub_array = array_init(length);

for(var n = 0; n < length; ++n)
{
    sub_array[n] = array[@height, n];
}

return sub_array;

#define array_reverse
///array_reverse(array)
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
//params: array, real (natural), [real (natural)]
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
var return_array = 0;
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

for(var i = 0; i < array_length(return_array); ++i)
{
    array[@i] = return_array[@i];
}

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
//params: value
//retruns: height of `array`

return array_height_2d(argument0);

#define array_insert
///array_insert(array, index, value)
//params: array, real (natural), value
//results: `array` with `value` inserted at `array[index]`, pushing back all items one step
///array_insert(array, height, index, value)
//params: array, real (natural), real (natural), value
//results: `array` with `value` inserted at `array[height, index]`, pushing back all items one step

_gme_arguments(array_insert, argument_count, 3, 4);

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
//retruns: array with each item as string characters

var str = argument0;

assert(is_string(str), "array_string(...): `string` must be string.");

var str_length = string_length(str);
var return_array = array_init(str_length);

for(var i = 0; i < str_length; ++i)
{
    return_array[i] = string_char_at(str, i + 1);
}

return return_array;
#define array_sort
///array_sort(array, [ascending = true])
//params: array, [real (bool)]
//results: `array` sorted. if sorting string: sorted alphabetically
//note: all items in `array` must be same type

_gme_arguments(array_sort, argument_count, 1, 2);

var array = argument[0];
var ascending = true; if(argument_count == 2) ascending = argument[1];

assert(is_array(array) && array_is_1d(array), "array_sort(...): `array` must be 1D array.");
assert(real_is_natural(ascending), "array_sort(...): `ascending` must be bool.");

//check array all same type
var array_type = type_of(array[0]);
var max_string_length = 0;
var length = array_length(array);
for(var i = 0; i < length; ++i)
{
    assert(array_type == type_of(array[i]), string_text("array_sort(...): All types in array must be the same."));
    
    if(array_type = "string")
    {
        max_string_length = max(max_string_length, string_length(array[i]));
    }
}

//sorted array
var sorted = 0;

if(array_type == "string")
{
    //RADIX Sort ('string' Edition)
    sorted = _gme_radix_sort_string(array, 0);
}
else
{
    //Quick Sort
    sorted = _gme_quick_sort(array);
    if(ascending) array_reverse(sorted);
}

for(var i = 0; i < length; ++i)
{
    array[@i] = sorted[i];
}

return sorted;

#define array_replace
///array_replace(array, index, value)
//params: array, real (natural), value
//results: `array[index]` replaced by `value`
///array_replace(array, height, index, value)
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

#define array_swap
///array_swap_item(array, index1, index2)
//params: array, real (natural), real (natural)
//results: modifies `array` by switching items at `index1` and `index2`
///array_swap_item(array, height, index1, index2)
//params: array, real (natural), real (natural), real (natural)
//results: modifies `array` at `height` by switching items at `index1` and `index2`

_gme_arguments(array_swap, argument_count, 3, 4);

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

var temp = array[@height, index2];
array[@height, index2] = array[@height, index1];
array[@height, index1] = temp;

return array;

#define array_is_1d
///array_is_1d(array)
//params: value
//retruns: true if `array` height == 1.

//if 1D array (array[0,n] == array[n])
return (array_height_2d(argument0) == 1);