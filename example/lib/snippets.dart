/// Snippets for supported languages in Flutter Syntax View
/// TODO: More complete examples.

/// C example code
const String CCode = r"""
#pragma once
#include <stdio.h>

/* Struct presenting a kind of animal. */
struct Animal {
  char* sound;
  char* kind;
}

int main(void) // the main entrypoint
{
  Animal dog;
  dog.sound = "woof";
  dog.kind = "dog";

  printf("This is an animal:\n");
  sprintf("Its sound is %s.\n", dog.sound);
  sprintf("It is a %s.\n", dog.kind);

#ifdef __WIN32__
  printf("Running on Win32 platform, either Windows or Wine.");
#else
  printf("Running on non-Win32 platform.");
#endif

  return 0;
}
""";

const String CPPCode = r"""
/* C++ modules support? Yes!
   Note that modules are available for C++ 20 and higher.
   TODO for SyntaxHighlighter class: Option for this */

// helloworld.cpp
export module helloworld;

export char* ostype() {
#ifdef __WIN32__
  return "Win32";
#else
  return "non-Win32";
#endif
}

export namespace hi {
  char* const english() { return "Hello!"; }
  char* const vietnamese() { return "Xin chao!"; }
}

// main.cpp
import helloworld;
import <iostream>;

int main(void) {
  for (int i = 0; i < 10; ++i)
  {
    std::cout << i << std::endl;
  }

  // lol hello in english
  std::cout << "Hello in English: " << hi::english() << std::endl;
  std::cout << "Hello in Vietnamese: " << hi::vietnamese() << std::enl;

  std::cout << ostype() << std::endl;
  return 0;
}
""";

const String DartCode = r"""
import 'dart:math' as math;

// Coffee class is the best!
class Coffee {
  late int _temperature;

  void heat() => _temperature = 100;
  void chill() => _temperature = -5;

  void sip() {
    final bool isTooHot = math.max(37, _temperature) > 37;
    if (isTooHot)
      print("myyy liiips!");
    else
      print("mmmmm refreshing!");
  }

  int? get temperature => temperature;
}
void main() {
  var coffee = Coffee();
  coffee.heat();
  coffee.sip();
  coffee.chill();
  coffee.sip();
}
/* And there
        you have it */""";

const String JavaCode = r"""
package mypackage; /* How to change this? */

import net.rim.device.api.command.Command;
/* A lot of imports */

public final class AboutScreen extends MainScreen
{
  public AboutScreen()
  {
    setTitle("About this project");
    
    VerticalFieldManager mainField = new VerticalFieldManager();
    mainField.setPadding(20, 20, 20, 20);

    LabelField projName = new LabelField("Alarmer");
    LabelField projVers = new LabelField("v1.0.0");

    // set the font for the title
    try
    {
        FontFamily sysFontFamily = FontFamily.forName(FontFamily.FAMILY_SYSTEM); // this can throw error
        Font titleFont = sysFontFamily.getFont(Font.BOLD, 14, Ui.UNITS_pt);
        Font subtitleFont = sysFontFamily.getFont(Font.LATIN_SCRIPT, 12, Ui.UNITS_pt);
        projName.setFont(titleFont);
        projVers.setFont(subtitleFont);
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }

    // repo open button
    ButtonField repoBtn = new ButtonField("Repository", ButtonField.CONSUME_CLICK);
    repoBtn.setCommand(new Command(new RepoBtnClickHandler()));

    // now tell mainField to add stuff...

    add(mainField); /* Add mainField to the screen */
  }
  
  protected boolean keyDown(int keycode, int time) {  
    // avoid 'Changes made!' dialog when we quit using Escape/Close button
  }
}

class RepoBtnClickHandler extends CommandHandler
{
  public void execute(ReadOnlyCommandMetadata metadata, Object context)
  {
    Dialog.inform("Open github.com/lebao3105/Alarmer.");
  }
}
""";

// The code below and above are taken from my (lebao3105) repositories
const String JSCode = r"""
function getHTMLTitleAndLastModified(path)
{
    var xmlHttp = new XMLHttpRequest();
    var result = [];

    xmlHttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200)
        {
            var htmlDoc = new DOMParser().parseFromString(this.responseText, 'text/html')
            result.push(htmlDoc.getElementsByTagName('title')[0].innerText);
            result.push(htmlDoc.getElementById('last-updated').innerText);
        }
    }
    xmlHttp.open('GET', '/content/' + path, false);
    xmlHttp.send(null);

    return result;
}
""";

const String KotlinCode = r"""
// https://www.programiz.com/kotlin-programming/examples/print-integer
import java.util.Scanner

fun main(args: Array<String>) {

    // Creates a reader instance which takes
    // input from standard input - keyboard
    val reader = Scanner(System.`in`)
    print("Enter a number: ")

    // nextInt() reads the next integer from the keyboard
    var integer:Int = reader.nextInt()

    // println() prints the following line to the output screen
    println("You entered: $integer")
}
""";

const String PythonCode = r"""
from examples import helloworld

class dog(Animal):
  def sound(this):
    print("woof woof woof")
  
  def kind(this) -> str:
    return "dog"

print(1234.56789 / 10.0)
obj = dog()
print(f"This is a {obj.kind()}, has {obj.sound()} sound.")
del obj
""";

const String SwiftCode = r"""
// A simple, small example SwiftUI view.

import SwiftUI

@ViewBuilder
func makeTitleWithSecondary(_ mainTitle:String, _ secondaryTitle: String) -> some View {
	HStack {
		Text(mainTitle)
			.padding(.vertical, 6)
		Spacer()
		Text(secondaryTitle)
			.font(.subheadline)
			.foregroundColor(.secondary)
			.padding(.vertical, 6)
	}
}

struct HelloWorldView: View {

  @State private var tapCount = 0;

  var body: some View {
    List {
      Label("Hello world!")

      Label("Button tapped $tapCount times")

      makeTitleWithSecondary("test", "secondary")

      Button {
        ++tapCount // never saw this on Swift tbh
      } label: {
        Label("Click me!")
      }
    }
  }
}
""";

const String YAMLCode = r"""
name: Hello world
version: 1.0

depends:
  apackage:
    vcs: https://github.com/...

description: |
  ## Hello world
  An awesome application!
""";