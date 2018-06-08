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