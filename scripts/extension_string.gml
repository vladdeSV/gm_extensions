#define extension_string


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
    //array
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
    joined += string(array[@n]);
    if(n != length - 1) joined += joiner;
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
    array_append(splits, string_slice(source, 0, next_find - 1));
    //trim away
    source = string_slice(source, next_find - 1 + string_length(separator), string_length(source));
    next_find = string_pos(separator, source);
}

array_append(splits, source);

return splits;

#define string_slice
///string_slice(string, from, to)
//params: string, real (natural), real (natural)
//retruns: portion of `string`. `from` (inclusive), `to` (exclusive).
//note: this function assumes position 0 is the first character, and the last character is at position `string_length(string) - 1`. however, due to the functions nature, the following is allowed `string_slice(string, 0, string_length(string)) == string`

var source = argument0;
var from = argument1;
var to = argument2;

assert(is_string(source), "string_slice(...): `string` must be string.");
var length = string_length(source);

assert(real_is_natural(from) && real_is_natural(to), "string_slice(...): `from` and `to` must be natural numbers.");
assert(from <= to, string_text("string_slice(...): `from`/`to` missmatch. `from` must be less than or equal `to`. `from`: ", from, ", `to`: ", to, "."));
assert(from >= 0 && to <= length, string_text("string_slice(...): Out of bounds: [", from, " .. ", to, "], `string` is [0 .. ", length, "]."));

var return_string = "";

for(var i = from + 1; i <= to; ++i)
{
    return_string += string_char_at(source, i);
}

return return_string;

#define string_substring
///string_substring(string, from, length);
//params: string, real (natural), real (natural)
//returns: string from index `from` to `from + length`. `string_substring("hello world!", 6, 3) == "wor")`

var source = argument0;
var from = argument1;
var length = argument2;

assert(is_string(source), "string_substring(...): `string` must be string.");
assert(real_is_natural(from), "string_substring(...): `from` must be natural number.");
assert(real_is_natural(length), "string_substring(...): `length` must be natural number.");
assert((from + length <= string_length(source)), "string_substring(...): `from+length` must be less or equal to `string` length.");

return string_slice(source, from, from + length);

#define string_find
///string_find(source, find, [nth = 1])
//params: string, string, [real (natural)]
//returns: position of `nth` occurance of `find` in `source`, where first character is at index 0. if not found, returns -1

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
    var d = string_pos(find, source) - 1;
    offset += d + string_length(find);
    source = string_slice(source, d + string_length(find), string_length(source));
}

var ret = string_pos(find, source) - 1;
var success = (ret != -1);
return ternary(success, ret + offset, -1);
