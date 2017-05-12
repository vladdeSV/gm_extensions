#define extension_algorithm

#define quick_sort
///quick_sort(array)
//params: array (real)
//returns: array of reals sorted

var array = argument0;

assert(is_array(array), "quick_sort(...): `array` must be 1D array.");

var length = array_length(array);
for(var i = 0; i < length; ++i)
{
    assert(is_real(array[i]), "quick_sort(...): All items in `array` must be reals.");
}

if(length == 0)
{
    return array_init(0);
}
else if(length == 1)
{
    return array_copy(array);
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
    var lhs = array_init(0);
    var mid = array_init(0);
    var rhs = array_init(0);
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
    
    //if empty array has content, remove "empty" identifier.
    lhs = array_sub(lhs,0);
    mid = array_sub(mid,0);
    rhs = array_sub(rhs,0);
    
    var ret = array_create(quick_sort(lhs), mid, quick_sort(rhs));
    
    return array_expand(ret);
}
