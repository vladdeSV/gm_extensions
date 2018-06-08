# GameMaker Library Extensions Specification

## Abstract

The goal of GameMaker Library Extensions (GME) is to add missing functions for the software GameMaker: Studio 1.4 (GMS). The additions are written in the native GameMaker Language (GML).

GME also strives towards creating a uniform standard for function and data type definitions.

## Argument data types

Any argument types must be described as either of the following GME Defined Types:

* `integer`, whole number
* `real`, floating point number
* `string`
* `pointer`, GMS pointer type
* `undefined`, equivalent to null
* `value<*>`, any value
* `array<*>`

Types followed by `<*>` can have an optional type specifier. Read more about [Type specifiers](#type-specifiers).

### Type specifiers

Certain types can have specifiers. Specifiers are defined as: the name of the type followed directly by the specifier within angle brackets.

The type which can have specifiers are:

* `value`
* `array`

A specifier, as the name suggests, specifies the value of the type. For instance, the items in an array can be of different types. By adding a type specifier, the array's item types can be limited to a specific type. Read more about [Array type specifiers](#array-type-specifiers).

#### `value` type specifier

The type `value` can be any type at all, including types which are not [listed above](#argument-data-types). This allows for the type to be special types such as `vec3` or `int64` by with `value<vec3>` or `value<int64>` respectively.

The `value` type must not contain any GME Defined Types.

#### `array` type specifier

Array specifiers can be nested. For instance, an array of integers is defined as `array<any<vec3>>`.

Two dimensional arrays are defined as `array<><+>`, where `+` is the mandatory type. This is due to the fact that GML is crap. //all single-dimension arrays actually are two-dimensional arrays with an height of 1.

Note: `array` is equivalent to `array<value>`. Thus, the latter is discouraged and should not be used.


# todo

## Functions

gamemaker allows for an unlimited amount of "white-space characters" after the first ///. this includes all kinds of white-space.

The first line of code (loc) must be begin with exactly three (3) forward-slashes, followed by an optional space characters.

Function must be defined in the following manner. "`<arguments>`" and "`, <comment>`" are optional.

```txt
///<function name>( [<arguments>] ) : <return type>[, <comment>]
```

Some examples of functions

```txt
///function1()
///function1(), real<integer>
```