## [0.0.1] - 04/26/2019

* First test release.

## [0.1.0] - 04/27/2019

* First stable release.

## [0.1.1] - 04/27/2019

* Fixed a Warning.

## [0.1.2] - 04/28/2019

* New Syntax Added (Java, Kotlin, Swift).
* New Theme Added (Ocean Sunset).

## [0.1.3] - 04/28/2019

* Fixed README.md


## [0.2.0] - 05/25/2019

* JavaScript Syntax Added & Fixed Duplicated Syntax KeyWord in Swift.

## [0.2.1] - 05/25/2019

* Syntax Theme is not required (Default: dracula).
* SDK minimun support upgraded from 2.1.0 to 2.2.2.
* Syntax Lines counter is now available. 

## [0.2.2] - 02/23/2020

* implemented abstraction.
* Added Editable Rich Text

## [1.0.0] - 02/23/2020

* Removed (Editable Rich Text due some platform errors)

## [2.0.0] - 10/04/2020

* Code Cleanup
* Now Zooming depends on gesture
* Added C Syntax Support
* Added C++ Syntax Support

## [2.1.0] - 10/04/2020

* Added YAML Syntax Support


## [2.2.0] - 13/01/2021

* Added vscode dark and light themes
* Added new themes screenshots

## [2.2.1] - 13/01/2021

* Fixed Theme screenshots not showing due invalid link

## [2.2.2] - 13/01/2021

* Fixed duplicated themes issue

## [3.2.2] - 21/02/2021

* Added Font size with a default value of 12.0 by @marwenx.
* Added Expansion (default to false) which allows the SyntaxView to be used inside a Column or a ListView... @marwenx.
* Added void, <cstdint> types and Preprocessor Conditional compilation ( #if, #else, #elif, #ifdef, #ifndef, #endif, and #pragma ) to C/C++ built in types parser

## [4.0.0] - 31/03/2021
* Revert softWrap for now due instability
* Removed Zooming with gestures due instability, now zooming is only supported with icon controls
* Upgraded string_scanner dependency to null safety stable version 1.1.0
* Executed $ dart migrate command which enabled Null safety support automatically
* Added late and required to Dart syntax keywords
* Added publish_to: "none" to example project's pubspec.yaml