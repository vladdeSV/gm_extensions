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
assert(real_is_natural(length), "array_init(...): `length` must be natural number.");

var array = 0;
if(length > 0)
{
    for(var h = 0; h < height; ++h)
    {
        array[h, length - 1] = 0;
    }
}
else
{
    array[height,0] = gme.array_empty;
}

return array;

#define array_create
///array_create(arg, ...)
//params: value, value...
//returns: creates an array from arguments

//array from arguments
var return_array = 0;
var offset = 0;

//copy all arguments to array
for(var i = 0; i < argument_count; ++i)
{
    var arg = argument[i];
    if(is_array(arg) && array_is_empty(arg))
    {
        --offset;
        continue;
    }
    
    return_array[i + offset] = arg;
}

//if no parameters were entered, return empty array
if(return_array == 0) return array_init(0);

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
//results: appends `value` to `array`. arrays are pointers, no need to return array
///array_append(array, height, value)
//params: array, real (natural), value
//results: appends `value` to `array` at `height`. arrays are pointers, no need to return array

_gme_arguments(array_append, argument_count, 2, 3);

if(argument_count == 2)
{
    var array = argument[0];
    var value = argument[1];
    
    assert(is_array(array), "array_append(...): `array` must be array.");
    assert(array_height(array) == 1, "array_append(...): `array` must be 1D");
    var length = array_length(array);
    assert(length > 0, "array_append(...): `array` must be initialized in order to append.");
    
    array[length] = value;

}
else if(argument_count == 3)
{
    var array = argument[0];
    var height = argument[1];
    var value = argument[2];
    
    assert(is_array(array), "array_append(...): `array` must be array.");
    assert(real_is_natural(height), "array_append(...): `height` must be natural number.");
    var length = array_length(array, height);
    assert(length > 0, "array_append(...): `array[height, ...]` must be initialized in order to append.");
 
    array[height, length] = value;
}

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

if(array_is_empty(array)) return array_init(0);

var length = array_length_2d(array, height);
var sub_array = array_init(length);

for(var n = 0; n < length; ++n)
{
    sub_array[n] = array[@height, n];
}

return sub_array;

#define array_reverse
///array_reverse(array, [inplace = false])
//params: array, [real (bool)]
//results: `array` with items in reverse order. modifies original array if `inplace` == true

_gme_arguments(array_reverse, argument_count, 1, 2);

var array = argument[0];
var inplace = false;
if(argument_count == 2)
{
    inplace = argument[1];
}

assert(is_array(array) && array_is_1d(array), "array_reverse(...): `array` must be 1D array.");
assert(real_is_natural(inplace), "array_reverse(...): `inplace` must be bool.");

var length = array_length(array);

if(inplace)
{
    for(var n = 0; n < floor(length/2); ++n)
    {
        var temp = array[@n];
        array[@n] = array[@(length - 1 - n)];
        array[@(length - 1 - n)] = temp;
    }
}
else
{
    var array = array_copy(array);
    var return_array = array_init(length);
    
    for(var i = 0; i < length; ++i)
    {
        return_array[i] = array[@(length - 1 - i)];
    }
    
    return return_array;
}

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
///array_expand(array, [deep = -1])
//params: array, [real (natural)]
//returns: returns array of all elements of nested arrays, to `deep` layers down. if `deep` == -1, expand all

_gme_arguments(array_expand, argument_count, 1, 2);

var array = argument[0];
var deep = -1;

if(argument_count == 2)
{
    deep = argument[1];
}

assert(is_array(array) && array_is_1d(array), "array_expand(...): `array` must be 1D array. Only 1D arrays can be expanded.");
assert(is_real(deep) && (deep >= -1) && (deep mod 1 == 0), "array_expand(...): `deep` must be natural number or -1.");

//if array is empty
if(array_is_empty(array)) return array_init(0);

var al = array_length_1d(array);
var return_array = 0;
var offset = 0;

for(var i = 0; i < al; ++i)
{
    var arg = array[i];
    var pos = i + offset;
    
    if(is_array(arg) && (deep == -1 || deep > 0))
    {
        if(deep > 0) --deep;
        var narr = array_expand(arg, deep);
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

return return_array;

#define array_length
///array_length(array, [height = 0])
//params: array, [real (natural)]
//retruns: length of `array`, at height `height`

_gme_arguments(array_length, argument_count, 1, 2);

var array = argument[0];
var height = 0;

if(argument_count == 2)
{
    height = argument[1];
}

assert(real_is_natural(height), "array_length(...): `height` must be natural number.");

return array_length_2d(array, height);

#define array_height
///array_height(array)
//params: array
//retruns: height of `array`. note: all arrays have a height, including 1D arrays which have the height of 1.

var array = argument0;

var height = array_height_2d(array);

if(array_is_empty(array)) --height;

return height;

#define array_insert
///array_insert(array, position, value, [inplace = false])
//params: array, real (natural), value, [real (bool)]
//returns: `array` with `value` inserted at `array[position]`. modifies original if `inplace` == true

var array = argument[0];
var position = argument[1];
var value = argument[2];
var inplace = false;

if(argument_count == 4) inplace = argument[3];

assert(is_array(array) && array_is_1d(array), "array_insert(...): `array` must be 1D array.");
assert(is_real(position) and ((position mod 1) == 0) and position >= 0, "array_insert(...): `position` must be positive integer");
assert(real_is_natural(inplace), "array_insert(...): `inplace` must be bool.");
var length = array_length(array);
assert(real_within(position, 0, length), string_text("array_insert(...): `position` must be between 0 and ", length, ", but `position` == ", position, "."));

//if not modifying original, copy array
if(!inplace)
{
    array = array_copy(array);
}

var half_end = array_slice(array, position, length);
if(is_array(half_end))
{
    //shift array one step left
    for(var i = length; i > position; --i)
    {
        array[@i] = array[@(i - 1)];
    }
}

array[@position] = value;

//if not modifying original, return array
if(!inplace) return array;


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
///array_sort(array, [ascending = false, inplace = false])
//params: array, [real (bool), real (bool)]
//retruns: array with elements sorted. all items in `array` must be same type

_gme_arguments(array_sort, argument_count, 1, 2, 3);

var array = argument[0];
var ascending = false;
var inplace = false;

if(argument_count >= 2) ascending = argument[1];
if(argument_count >= 3) inplace = argument[2];

assert(is_array(array) && array_is_1d(array), "array_sort(...): `array` must be 1D array.");
assert(real_is_natural(ascending), "array_sort(...): `ascending` must be bool.");
assert(real_is_natural(inplace), "array_sort(...): `inplace` must be bool.");

//check array all same type
var array_type = type_of(array[0]);
var length = array_length(array);
for(var i = 0; i < length; ++i)
{
    var type = type_of(array[i]);
    assert(array_type == type, string_text("array_sort(...): All types in array must be the same. ", array[i], " at poition ", i, " is of type ", type, "."));
}

//
if(is_string(array[0]))
{
    log("WARNING: sorting strings is not yet implemented.");
    return array;
}
//is real
else
{
    var sorted = quick_sort(array);
    if(ascending) array_reverse(sorted, true);
    
    if(inplace)
    {
        for(var i = 0; i < length; ++i)
        {
            array[@i] = sorted[i];
        }
    }
    else
    {
        return sorted;
    }
}

#define array_is_1d
///array_is_1d(array)
//params: array
//retruns: true if `array` height == 1, or `array` == empty 1D array

var array = argument0;

assert(is_array(array), "array_is_1d(...): `array` must be array.");

return
(
    //if 1D array (array[0,n] == array[n])
    array_height_2d(array) == 1
    
    ||
    
    //special check to see if array is empty
    (
        array_height_2d(array) == 2 &&
        array_is_empty(array)
    )
);

#define array_is_empty
///array_is_empty(array)
//params: array
//returns: true if array is "empty" (by gm_extensoins definition)

var array = argument0;

assert(is_array(array), "array_is_empty(...): `array` must be array.");

var height = array_height_2d(array);
if(height < 2) return false;

if(array[height - 1, 0] != gme.array_empty)
{
    return false;
}

for(var h = 0; h < height - 1; ++h)
{
    if(array_length_2d(array, h) != 0)
    {
        return false;
    }
}

return true;

/*
//gm_extensions approach of empty 1D array
return
(
    //if 1D array length == 0 (means array is 2D w/ height > 1)
    array_length_2d(array, 0) == 0 &&
    
    //check array height == 2 (special case for gm_extensions)
    array_height_2d(array) == 2 &&
    
    //if height == 2, then first position in 2D array must be initialized.
    array[1,0] == _gme.array_empty
)
*/
