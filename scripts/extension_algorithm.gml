#define extension_algorithm

#define quick_sort
///quick_sort(numbers...)
//params: real...
//returns: array of reals sorted
///quick_sort(array)
//params: array (real)
//returns: array of reals sorted

assert(argument_count > 0, "quick_sort(...): Arguments must be provided.");

if(argument_count == 1 && is_array(argument[0]))
{
    var array = argument0;
    
    assert(is_array(array), "quick_sort(...): `array` must be 1D array.");
    
    var length = array_length(array);
    for(var i = 0; i < length; ++i)
    {
        assert(is_real(array[i]), "quick_sort(...): All items in `array` must be reals.");
    }
    
    if(length == 0 || length == 1)
    {
        return array;
    }
    else if(length == 2)
    {
        var a = array[0];
        var b = array[1];
        if(a > b)
        {
            return array_create(a, b);
        }
        else
        {
            return array_create(b, a);
        }
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
        
        if(is_array(lhs)) lhs = quick_sort(lhs);
        if(is_array(rhs)) rhs = quick_sort(rhs);
        
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
        var arg = argument[i];
        assert(is_real(arg), "quick_sort(...): All arguments must be reals.");
        sorting_array[i] = arg;
    }
    
    return quick_sort(sorting_array);
}
