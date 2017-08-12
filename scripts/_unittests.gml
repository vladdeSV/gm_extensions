///unittests
//if-syntax is used to categorize tests
var unittest = true;

///array_init
if(unittest)
{
    var array_empty = array_init();
    assert(array_is_1d(array_empty));
    assert(array_length_1d(array_empty) == 0);

    var array_1d = array_init(2);
    assert(array_1d[0] == 0);
    assert(array_1d[1] == 0);
    assert(array_length_1d(array_1d) == 2);

    var array_2d = array_init(4, 2);
    assert(array_2d[0,0] == 0);
    assert(array_2d[1,1] == 0);
    assert(array_2d[3,1] == 0);
    assert(array_height_2d(array_2d) == 4);
    assert(array_length_2d(array_2d, 0) == 2);
}

///array_of
if(unittest)
{
    var array = array_of(0, 1, "two", 3, 4);
    assert(array[3] == 3);
    assert(array[2] == "two");
}

///array_at
if(unittest)
{
    var array_1d = 0;
    array_1d[2] = 42;
    assert(array_at(array_1d, 0) == 0);
    assert(array_at(array_1d, 2) == 42);

    var array_2d = 0;
    array_2d[4, 2] = 3;
    assert(array_at(array_2d, 4, 2) == 3);
}

///array_append
if(unittest)
{
    var array_1d = array_init();
    array_append(array_1d, 2);
    assert(array_equals(array_1d, array_of(2)));
}

///array_clone
if(unittest)
{
    //copy 1D arrays
    var array_1d = 0;
        array_1d[0] = 42;

    var new_array_1d = array_clone(array_1d);
        new_array_1d[0] = 3;

    assert(new_array_1d[0] != array_1d[0]);
    assert(array_1d[0] == 42);

    //copy 2D arrays
    var array_2d = 0;
        array_2d[4, 2] = 6;
    var new_array_2d = array_clone(array_2d);
        new_array_2d[4, 2] = 5;

    assert(array_at(    array_2d, 4, 2) == 6);
    assert(array_at(new_array_2d, 4, 2) != 6);
    assert(array_at(new_array_2d, 4, 2) == 5);
}

///array_sub
if(unittest)
{
    var array_2d = array_init(3,2);
    array_2d[0,0] = "hello"; array_2d[0,1] = "world"; array_2d[0,2] = "!!!";
    array_2d[1,0] = 1; array_2d[1,1] = 2; array_2d[1,2] = 3;

    //assert(array_equal(array_sub(array_2d, 0), array_of("hello", "world", "!!!")));
    //assert(array_equal(array_sub(array_2d, 1), array_of(1, 2, 3)));
}

///array_split
if(unittest)
{
    var splits = array_split("hello-world-again.", "-");
    var test = 0;
    test[0] = "hello";
    test[1] = "world";
    test[2] = "again.";

    assert(splits[0] == test[0]);
    assert(splits[1] == test[1]);
    assert(splits[2] == test[2]);
}

///array_reverse
if(unittest)
{
    var array_1d = array_of(1,2,3,4);
    //array_reversed modifies original array.
    var array_1d_reversed = array_reverse(array_1d);
    assert(array_equals(array_1d_reversed, array_of(4,3,2,1)));
}

///array_find
if(unittest)
{
    //find first value
    var array_1d = array_of(1,2,3,4);
    assert(array_find(array_1d, 3) == 2);
    assert(array_find(array_1d, 16) == -1);

    //find 2nd value
    array_1d = array_of("number", "", "", "number");
    assert(array_find(array_1d, "number", 2) != 0);
    assert(array_find(array_1d, "number", 2) == 3);
}

///array_count
if(unittest)
{
    var array_1d = array_of(1,4,1,1,"tree");
    assert(array_count(array_1d, 1) == 3);
    assert(array_count(array_1d, 4) == 1);
    assert(array_count(array_1d, "car") == 0);
}

//array_exists
if(unittest)
{
    var array_1d = array_of(1,2,3,4,5);
    assert(array_exists(array_1d, 1) == true);
    assert(array_exists(array_1d, 6) == false);
    assert(array_exists(array_1d, "tree") == false);
}

///array_expand
if(unittest)
{
    var a1 = array_of("abs","dps","fps");
    var a2 = array_of(3, 4, 5);
    var a3 = array_of(a1, a2);
    var a4 = array_of("tree", a3);
    var a5 = array_of("ball", a4, "house");

    //nested arrays
    var expanded_array = array_expand(a3);
    assert(array_equals(expanded_array, array_of("abs","dps","fps",3,4,5)));

    //multiple layers of arrays nested
    expanded_array = array_expand(a5);
    assert(array_equals(expanded_array, array_of("ball","tree","abs","dps","fps",3,4,5,"house")));

    log("asdasd");
    //level limit
    expanded_array = array_expand(a5);

    //no expansion
    var array = array_of("test");
    assert(array_equals(array_expand(array), array));
}

///array_length
if(unittest)
{
    var array_1d = array_of(42,134,"house");
    assert(array_length(array_1d) == 3);

    var array_2d = 0;
    array_2d[0,3] = 0;
    array_2d[1,2] = 0;
    assert(array_length(array_2d)    == 4);
    assert(array_length(array_2d, 0) == 4);
    assert(array_length(array_2d, 1) == 3);
}

///array_slice
if(unittest)
{
    var array_1d = array_of(0,1,2,3,4,5,6,7);

    assert(array_equals(array_slice(array_1d, 0, 3), array_of(0,1,2)));
    assert(array_equals(array_slice(array_1d, 5, 8), array_of(5,6,7)));
    assert(array_equals(array_slice(array_1d, 2, 2), array_of()));
    
    array_1d = array_of("car", "house", 3, "fire");
    
    assert(array_equals(array_slice(array_1d, 1, 2), array_of("house")));
    assert(array_equals(array_slice(array_1d, 0, 3), array_of("car", "house", 3)));
}

///array_insert
if(unittest)
{
    var array_1d = array_of(1,2,3,5);
    array_1d = array_insert(array_1d, 3, 4);
    assert(array_equals(array_1d, array_of(1,2,3,4,5)));

    array_1d = array_of("house", "ball", "car");
    array_insert(array_1d, 0, "number");
    assert(array_equals(array_1d, array_of("number","house","ball","car")));
}

///array_string
if(unittest)
{
    var str = "12345";
    var array = array_string(str);
    assert(string_length(str) == array_length(array));
    for(var n = 0; n < string_length(str); ++n)
    {
        assert(array[n] == string_char_at(str, n + 1));
    }
}

///array_sort
if(unittest)
{
    var array = array_of(2,5,4,1,3);
    //ascending
    var sorted = array_sort(array);
    assert(array_equals(sorted, array_of(1,2,3,4,5)));

    array = array_of(2,5,4,1,3);
    //descending
    sorted = array_sort(array, false);
    assert(array_equals(sorted, array_of(5,4,3,2,1)));

    array = array_of("banana", "apple", "asteroid");
    assert(array_equals(array_sort(array), array_of("apple", "asteroid", "banana")));
}

///array_is_1d
if(unittest)
{
    var array = array_init(4);
    assert(array_is_1d(array));

    array = array_init(3, 2);
    assert(!array_is_1d(array));

    array = array_init(1, 5);
    assert(array_is_1d(array));
}

///array_replace
if(unittest)
{
    var array = array_of("banana", "pineapple", "lumberjack");
    array = array_replace(array, 1, 42);
    assert(array_equals(array, array_of("banana", 42, "lumberjack")));

    array = array_of("one", "two", "three");
    array_replace(array, 2, 3);
    assert(array_equals(array, array_of("one", "two", 3)));
}

///real_within
if(unittest)
{
    assert( real_within(7,    5, 10));
    assert( real_within(8.65, 5, 10));
    assert( real_within(5,    5, 10));
    assert( real_within(10,   5, 10));
    assert(!real_within(15,   5, 10));
    assert(!real_within(3,    5, 10));
}

//real_within_exclusive
if(unittest)
{
    assert( real_within_exlusive(7,    5, 10));
    assert( real_within_exlusive(8.65, 5, 10));
    assert(!real_within_exlusive(5,    5, 10));
    assert(!real_within_exlusive(10,   5, 10));
    assert(!real_within_exlusive(15,   5, 10));
    assert(!real_within_exlusive(3,    5, 10));
}

///real_is_integer
if(unittest)
{
    assert( real_is_integer(-4));
    assert( real_is_integer(0));
    assert( real_is_integer(3));
    assert(!real_is_integer(1.25));
}

///real_is_natural
if(unittest)
{
    assert(!real_is_natural(-4));
    assert( real_is_natural(0));
    assert( real_is_natural(3));
    assert(!real_is_natural(1.25));
}

///string_text
if(unittest)
{
    assert(string_text("hello ", 42, " number") == "hello 42 number");
    assert(string_text("an array: ", array_of(1,"two",3)) == "an array: [1, two, 3]");
}

///string_join
if(unittest)
{
    assert(string_join(array_of(4,"three",2,1), ", ") == "4, three, 2, 1");
    assert(string_join(array_of("old","folks","home"), " ~ ") == "old ~ folks ~ home");
}

///ds_list_swap
if(unittest)
{
    //someday...
}

//*/
game_end();
