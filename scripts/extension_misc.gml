#define extension_misc


#define log
///log(...)
//params: value...
//results: shorthand for `show_debug_message`

var array = 0;
for(var i = 0; i < argument_count; ++i)
{
    array[i] = argument[i];
}

show_debug_message(string_text(array));

#define assert
///assert(comparison, [message])
//params: real (boolean), string
//results: if `comparison` is false, show `message` and exit

//if arguments are not 1 or 2, exit.
if(!(1 <= argument_count && argument_count <= 2))
{
    show_message("ASSERTION ERROR: Wrong assertion argument count.");
    game_end();
}

//if `comparison` did not succeed
else if(argument[0] == false)
{
    //show `message`. if only one argument provided, show default message
    if(argument_count == 1) { show_message("Assertion failed!"); }
    else { show_message("ASSERTION ERROR: " + argument[1]); }
    
    //end, as something went wrong
    game_end();
}

#define noop
///noop()
//results: nothing. noop is shorthand for "no operation"

#define type_of
///type_of(variable)
//value
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

return "unknown";