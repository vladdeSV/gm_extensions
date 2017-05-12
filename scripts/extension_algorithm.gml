#define extension_algorithm

#define quick_sort
///quick_sort(array)
//params: array (real)
//returns: array of reals sorted

var array = argument0;

assert(is_array(array) && array_height(array) == 1, "quick_sort(...): `array` must be 1D array.");

var length = array_length(array);
for(var i = 0; i < length; ++i)
{
    assert(is_real(array[i]), "quick_sort(...): All items in `array` must be reals.");
}

if(length == 1)
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
    var rhs = 0;
    var pivot = 0;
}
