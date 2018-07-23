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

, where each comma-separated argument in `{arguments}` is any of the following declarations, in order of appearance:

1. `{argument name}: {argument type}`.
2. `[{optional argument name}: {argument type} = {default value}]`.
3. `{argument name}: {argument type}...`.

The return type, including the comma (`: {return type}`), must be ommited if the function does not return any value.

See the [Examples of function declarations](#examples-of-function-declarations) for different variations of the declaration syntax.

### Function argument names

Function declaration's argument names must adhere to the [GML declaration of a variable name](https://docs.yoyogames.com/source/dadiospice/002_reference/001_gml%20language%20overview/variables/index.html):

> [...] must start with a letter and can contain only letters, numbers, and the underscore symbol '_' with a maximum length of 64 symbols.

Additional constraints for argument names are:

1. Letters must only contain letters from `a` to `Z`.
2. Letters should only be lowercase, however uppercase letters are permitted.

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

The `value` type must not specify any type which is defined by GMETD, but rather explicity types not defined my GMETD

## Examples of type specifiers

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

## Examples of function declarations

```gml
///scr0()
```

```gml
///scr1(): real<integer>
```

```gml
///scr2(f: value, [s: string = ""])
```

```gml
///scr3(f: value, [s: real = 1], [t: real<integer> = 2]): array<><real<integer>>
/// a comment
///another comment
```

```gml
///scr4(f: real<integer>, s: value...)
```

---

Author: Vladimirs Nordholm  
Last revision: 23th of July, 2018
