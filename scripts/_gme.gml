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
///_gme_quick_sort(numbers...)
//params: real...
//returns: array of reals sorted
///_gme_quick_sort(array)
//params: array (real)
//returns: array of reals sorted

if(argument_count == 1 && is_array(argument[0]))
{
    var array = argument0;
    
    assert(is_array(array) && array_is_1d(array), "quick_sort(...): `array` must be 1D array.");
    
    var length = array_length(array);
    if(length == 0) return array;
    
    var array_type = type_of(array[0]);
    for(var i = 0; i < length; ++i)
    {
        assert(type_of(array[i]) == array_type, "quick_sort(...): All items in `array` must be of same type.");
    }
    
    if(length == 1)
    {
        return array;
    }
    else if(length == 2)
    {
        var a = array[0];
        var b = array[1];
        if(a > b) return array_create(a, b);
        else      return array_create(b, a);
    }
    else
    {
        var lhs = 0;
        var mid = 0;
        var rhs = 0;
        var pivot_pos = floor(length/2);
        var pivot = array[pivot_pos];
        
        for(var i = 0; i < length; ++i)
        {
            var value = array[i];
            if(value > pivot)
            {
                lhs[array_length(lhs)] = value;
            }
            else if(value == pivot)
            {
                mid[array_length(mid)] = value;
            }
            else if(value < pivot)
            {
                rhs[array_length(rhs)] = value;
            }
        }
        
        if(is_array(lhs)) lhs = _gme_quick_sort(lhs);
        if(is_array(rhs)) rhs = _gme_quick_sort(rhs);
        
        var return_array = 0;
        
        for(var i = 0; i < array_length(lhs); ++i)
        {
            return_array[array_length(return_array)] = lhs[i];
        }
        
        for(var i = 0; i < array_length(mid); ++i)
        {
            return_array[array_length(return_array)] = mid[i];
        }
        
        for(var i = 0; i < array_length(rhs); ++i)
        {
            return_array[array_length(return_array)] = rhs[i];
        }
        
        return array_expand(return_array);
    }
}
else
{
    var sorting_array = array_init(argument_count);
    for(var i = 0; i < argument_count; ++i)
    {
        sorting_array[i] = argument[i];
    }
    
    return _gme_quick_sort(sorting_array);
}

#define _gme_radix_sort_string
///radix_quick_sort(array, sorting_by_nth_character)

var array = argument0;
var nth = argument1;

var bucket = 0;
var max_length = 0;

for(var i = 0; i < array_length(array); ++i)
{
    var item = array[i];
    
    //keep track of maxumum length
    max_length = max(max_length, string_length(item));
    var byte = string_byte_at(item, nth + 1);
    
    bucket[byte, array_length(bucket, byte)] = item;

}

var return_array = 0;

for(var i = 0; i < array_height(bucket); ++i)
{
    var blen = array_length(bucket, i);
    if(array_length(bucket, i))
    {
        var temp_array = 0;
        
        if(nth <= max_length && blen > 1)
        {
            var ns = array_sub(bucket, i);
            temp_array = _gme_radix_sort_string(ns, nth + 1);
        }
        else
        {
            temp_array = array_sub(bucket, i);
        }
        
        //sort arrays based on length
        
        var strings_sorted_by_length_array = 0;
        for(var j = 0; j < array_length(temp_array); ++j)
        {
            var item = temp_array[j];
            strings_sorted_by_length_array[string_length(item), array_length(strings_sorted_by_length_array, string_length(item))] = item;
        }
        
        var n = 0;
        for(var yy = 0; yy < array_height(strings_sorted_by_length_array); ++yy)
        {
            var l = array_length(strings_sorted_by_length_array, yy);
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
        
        for(var j = 0; j < array_length(temp_array); ++j)
        {
            return_array[array_length(return_array)] = temp_array[j];
        }
    }
}

return return_array;
