/** This file parses all scripts in the GameMaker 1.4 Library Extensions.
 * Creates one file which contains all extensions in `output/gm_extensions.gml`.
 * Creates reference file `reference.md`.
 */

import std.file : readText, dirEntries, SpanMode;
import std.stdio : File, write, writeln;
import std.string : replace, split, strip;
import std.algorithm : canFind;
import std.experimental.logger : log, logf;

//find all script files
//store function name, and its overloads

/*
struct Category
{
    string category;
    FunctionDefinition[] functionDefinitions;
}

struct FunctionDefinition
{
    string location;
    uint line;

    string name;
    Function[] functions;
}

struct Function
{
    string name;
    string params;
    string comment;
}
*/

void main()
{
    //Category[] categories;

    //init files
    File output = File("output/gm_extensions.gml", "w");
    output.writeln("#define gm_extensions\n///Game Maker 1.4 Library Extensions\n");

    File reference = File("reference.md", "w");
    reference.writeln("# GameMaker 1.4 Library Extensions Reference\n");

    auto scripts = dirEntries("scripts/", "*.gml", SpanMode.shallow);
    foreach(script; scripts)
    {
        string fileName = script.name.split("/")[$-1]; //eg "extension_array.gml"

        //contains all lines of code in the extension
        string[] lines = readText(script.name).replace("\r\n", "\n").split("\n");

        //output all loc to 'output/gm_extensions.gml'
        foreach(line; lines)
        {
            if(line.length > 18 && line[0 .. 18] == "#define extension_") continue;

            output.writeln(lines);
        }

        //check filename, if should be exluded from reference
        if(["_gme.gml"].canFind(fileName)) continue;


        //outputting references is for another day ¯\_(ツ)_/¯
    }

}
