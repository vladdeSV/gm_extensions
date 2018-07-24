# GameMaker Library Extensions' Function Declaration Specification  [[ in development ]]

This document aims to create a unified specification GameMaker Studio function declarations.

> The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
> NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
> "OPTIONAL" in this document are to be interpreted as described in
> [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Function declarations

All functions (commonly referred to as "scripts") must be declared with a GameMaker Library Extensions' Function Declaration Specification funciton declaration. The first line of a script defines the functions declaration, must follow the following syntax:

```gml
///{function name}({arguments}): {return type}
```

, where each argument in `{arguments}` is "comma space"-separated (`, `) and any of the following declarations:

1. `{argument name}: {argument type}`.
2. `{argument name}: {argument type}...`
3. `[{optional argument name}: {argument type} = {default value}]`.

, with the following restrictions:

* All arguments following an optional argument must also be declared optional.
* No arguments may come after a type using the spread operator. Read more about the [Spread operator](#spread-operator).

Argument and return types may only be declared as a single type, of which described in the [GameMaker Libaray Extension Type Declarations](#gamemaker-libaray-extension-type-declarations).

The return type, including the comma (`: {return type}`), must be ommited if the function does not return any value.

See the [Examples of function declarations](#examples-of-function-declarations) for different variations of the declaration syntax.

### Function argument names

Function declaration's argument names must adhere to the [GML declaration of a variable name](https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/variables/index.html):

> [...] must start with a letter and can contain only letters, numbers, and the underscore symbol '_' with a maximum length of 64 symbols.

, with the additional constraints that all letters must only be letters in the English alphabet.

If an argument name contains multiple words, the words should be separated using underscores `_`, to better fit with the already existing GMS library. Letters should only be lowercase, however uppercase letters are permitted.

### Return type

Any function which returns a value with the `return` keyword (ex. `return 42;`) must declare the type of the return value.

### Function comments

Function declarations can be supplemented with comments, which are lines directly followed the function declaration and are prefixed with `///`. Example:

```gml
///is_array(val: value): real<boolean>
/// Checks if `val` is an array
/// Returns: bool, true if array, false if not
```

## GameMaker Libaray Extension Type Declarations

All function declarations' value types must be defined as either of the following GameMaker Libaray Extension Type Declarations (GMETD):

* `real`, any number.
* `string`.
* `array`.
* `value`, any value at all.
* `undefined`, absence of a value.

All types can be suffixed with the spread operator `...`.

The types `real`, `array`, and `value` can have an optional type specifier. Read more about [Type specifiers](#type-specifiers).

The type `array` can be prefixed with an ampersand `&` to indicate that variable will be used as a reference. Read more about the [Array reference marker](#array-reference-marker).

### Spread operator

Any type suffixed with three dots `...` indicates there can be any number of arguments in its place. For the function declaration `///log(v: value...)`, all following calls are permitted:

* `log();`.
* `log(1);`.
* `log("foo", "bar");`.
* `log(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, "etc");`.

A function can have specifically declared arguments declared before the spread operator. For instance, for the function declaration `///warn(level: real, name: string, v: value...)` the following calls are legal:

* `warn(1, "foo");`.
* `warn(2, "bar", 3.1415);`.
* `warn(3, "baz", 42, "test", 1337);`.
* `warn(4, "foo", "bar", "baz", "buz");`.

### Type specifiers

The optional type specifier is defined as `{type}<{specifier}>`, and limits the value type to a certain gategory.

#### Array type specifiers

One-dimensional (1D) arrays are explicitly defined as `array<>`, and defining the items' type must be done with `array<{type}>`.

Two-dimensional (2D) arrays are explicitly defined as `array<><>`, and defining the items' type must be done with `array<><{type}>`.

It is discouraged to specify the type specifier for arrays as only `value` (`array<value>` and `array<><value>`). If the desired array item type is specifically `value`, the type should be ommited, leaving only `array<>` or `array<><>`.

#### Value type specifiers

The `value` type must not specify any type which is defined by GMETD.

### Examples of type specifiers

* `real<integer>`, whole numbers.
* `real<boolean>`, boolean value.
  * A boolean is not strictly equal to the values `1` or `0`. A boolean value is the result of using comparator operators, such as `==`, `>=`, `!=`, etc.
  * Values which are **not** of the type `boolean` include
    * The return value from statments using "combining operators" (such as `&&`, `^^`, and `||`).
    * The return value of the NOT operator (`!`).
* `real<ds_list>`, a `ds_list`, which is represented by a real.
* `array<real>`, array (1D) of numbers.
* `array<real<integer>>`, array of whole numbers.
* `array<real<ds_list>>`, array of `ds_list`s.
* `array<>`, 1D array
* `array<><>`, 2D array
* `array<><real>`, 2D array of numbers.
* `array<><real<integer>>`, 2D array of whole numbers.
* `value<pointer<buffer>>`
  * Note: A `value` type specifier must not be a type defined by [GMETD](#gamemaker-libaray-extension-type-declarations). Usage of a `value` type specifier should not be used unless strictly required by the function, such as a pointer to a buffer or [any other type used by GMS](https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/typeof.html).
  * As there is no clear specification of how `value` should be defined, it is up to the developer to ensure the type is clear and consistent with previous implementations of `value` type specifiers.

### Array reference marker

If an argument of the type `array` will be be modified by reference, then the type must be prefixed with an ampersand `&`. If the type is not modified by reference then it should not be declared with an array reference marker.

## Examples of function declarations

```gml
///scr0()
```

```gml
///scr1(): real<integer>
```

```gml
///scr2(f: value, [s: string = ""], [n: real = 42])
/// multiple optional arguments
```

```gml
///scr3(f: value, [s: real = 1], [t: real<integer> = 2]): array<><real<integer>>
/// a comment
///another comment
```

```gml
///scr4(f: real<integer>, s: value...)
```

```gml
///scr4(arr: &array)
```

---

Author: Vladimirs Nordholm  
Last revision: 24th of July, 2018
