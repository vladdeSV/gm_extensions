#define extension_gme
enum _gme
{
    array_empty = "_gme_array_empty",
}

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
