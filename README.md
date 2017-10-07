# GameMaker Library Extensions
[![img](https://img.shields.io/badge/GM-1.4-green.svg)](#) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/vladdeSV/gm_extensions/master/LICENSE.md)

This library aims to add missing features from the standard GameMaker 1.4 library.

There are around **[40 scripts](REFERENCE.md) (eg. `array_sort`, `array_slice`, `string_join`, `array_split`)** for general purpose usage!

## Download & Installation
There are multiple ways to get the library extensions.

### GameMaker: Marketplace
* Download the library via [the Marketplace](https://marketplace.yoyogames.com/assets/5870/gamemaker-library-extensions).

### Manually
1. Go the the [releases page](https://github.com/vladdeSV/gm_extensions/releases).
1. Find and download the most recent `gm_extensions.gml` file.
1. In your GameMaker project, include the file.

### Development-build
1. Install [dmd](https://dlang.org/download.html).
1. Clone this repository, `git clone https://github.com/vladdeSV/gm_extensions.git`.
1. Execute the extractor in the project via the *Command Prompt*, `rdmd extractor.d`.
1. In your GameMaker project, include the file `output/gm_extensions.gml`.

## Resources
* Check out the [REFERENCE](REFERENCE.md)!

The target of this is library is primarily aimed at GameMaker 1.4, but will most likely work with GameMaker 2.

## Acknowledgments
This project is not affiliated GameMaker or YoYoGames, but I definitely feel this should be available to everyone.

Special thanks to @twisterghost (Michael Barrett) for inspiration with his library [gdash](https://github.com/gm-core/gdash).
