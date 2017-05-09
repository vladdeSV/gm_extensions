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
///string_join(array, joiner)
//params: array, string
//returns: string with items in `array` joined by `joiner`

var array = argument0;
var joiner = argument1;

assert(is_array(array) && array_height_2d(array) == 1, "string_join(...): `array` must be 1D array.");
assert(is_string(joiner), "string_join(...): `joiner` must be string.");

var length = array_length_1d(array);
var joined = "";

for(var n = 0; n < length; ++n)
{
    joined += string(array[@n]);
    if(n != length - 1) joined += joiner;
}

return joined;