#define extension_ds_list


#define ds_list_swap
///ds_list_swap(id, index_1, index_2)
//params: ds_list, real (natural), real (natural)
//results: swaps two elements, `index_1` and `index_2`, in a ds_list

var list = argument0;
var index_1 = argument1;
var index_2 = argument2;

//assert(is_ds_list(list), "ds_list_swap(...): `list` must be ds_list.");
assert(real_is_natural(index_1) && real_is_natural(index_2), "ds_list_swap(...): `index_1` and `index_2` must be natural numbers.");

var temp = ds_list_find_value(argument0, argument1);
ds_list_replace(argument0, argument1, ds_list_find_value(argument0, argument2));
ds_list_replace(argument0, argument2, temp);