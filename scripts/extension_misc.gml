#define extension_misc


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