# GameMaker Library Extensions' Function Definition Specification RC1

## Function declarations

All functions (commonly referred to as "scripts") must be declared with a funciton declaration. The first line of a function must follow the following syntax:

```gml
///{function name}({first argument}: {argument type}, {second argument}: {argument type}, [{optional argument}: {argument type} = {default value}], [{optional argument}: {argument type} = {default value}]){: {return type}, if function returns value}
```

Function names must be unique only contain letters, numbers, and underscores.

Function declaration's argument names must adhere to the [GML definition of a variable name](https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/variables/index.html):

> [...] must start with a letter and can contain only letters, numbers, and the underscore symbol '_' with a maximum length of 64 symbols.

Function declarations can be supplemented with comments, which are lines directly followed the function and prefixed with `///`. Example:

```
///is_array(val: value): real<integer>
/// Checks if `val` is an array
/// Returns: bool, true if array, false if not
```

## GameMaker Libaray Extension Type Definitions

All function declarations' value types must be defined as either of the following GameMaker Libaray Extension Type Definitions (GMETD):

* `real<*>`, any number
* `array<*>`
* `value<*>`, any value at all
* `string`
* `undefined`, absence of a value

Types followed by `<*>` can have an optional type specifier. Read more about [Type specifiers](#type-specifiers).

### Type specifiers

The optional type specifier is defined as `{type}<{specifier}>`, and limits the value type to a certain gategory. The purpose of the specifier is to signify the intent of. Examples of type specifiers are:

* `real<integer>`, whole numbers.
* `real<boolean>`, boolean value.
  * This is not strictly equal to the values `1` or `0`. A boolean value is the result of using comparator operators, such as `==`, `>=`, `!=`, etc.
* `real<ds_list>`, `ds_list`s.
* `array<real>`, array (1D) of numbers.
* `array<real<integer>>`, array of whole numbers.
* `array<real<ds_list>>`, array of `ds_list`s.
* `array<><real>`, nested (2D) array of numbers.
* `array<><real<integer>>`, nested (2D) array of whole numbers.
* `value<pointer<buffer>>`
  * Note: A `value` type specifier must not be a type defined by [GMETD](gamemaker-libaray-extension-type-definitions). Usage of a `value` type specifier should not be used unless strictly required by the function, such as a pointer to a buffer or [any other type used by GMS](https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/typeof.html).
  * As there is no clear specification of how `value` should be defined, it is up to the developer to ensure the type is clear and consistent with previous implementations of `value` type specifiers.


## Examples of function definitions

```gml
///scr0()
```

```gml
///scr1(): real<integer>
/// Get a number
```

```gml
///scr2(f: any, [s: value = 1], [t: value = 2]): array<><real<integer>>
```

```gml
///scr3(f: any, [s: value = 1])
```