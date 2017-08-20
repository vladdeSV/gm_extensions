#define extension_real


#define real_within
///real_within(number, min, max)
//params: real, real, real
//returns: true if number is withing range min/max (inclusive: min <= number <= max)

var number = argument0;
var minimum = argument1;
var maximum = argument2;

assert(is_real(number) && is_real(minimum) && is_real(maximum), "`number`, `minimum`, and `maximum` must be numbers.");

return ((minimum <= number) && (number <= maximum));

#define real_within_exclusive
///real_within_exclusive(number, min, max)
//params: real, real, real
//returns: true if number is withing range min/max (exclusive: min < number < max)

var number = argument0;
var minimum = argument1;
var maximum = argument2;

assert(is_real(number) && is_real(minimum) && is_real(maximum), "`number`, `minimum`, and `maximum` must be numbers.");

return ((minimum < number) && (number < maximum));

#define real_is_integer
///real_is_integer(number)
//params: real
//returns: true if `number` is integer (no decimals)

var number = argument0;

return (is_real(number) && (number mod 1) == 0);

#define real_is_natural
///real_is_natural(number)
//params: real
//returns: true if number is natural number (integer and greater or equal to 0)

var number = argument0;

return (real_is_integer(number) && number >= 0);