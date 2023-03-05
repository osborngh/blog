---
title: "Speeding Up Rust With Mold"
date: 2023-03-05T00:52:41Z
author: "Da Vinci"
tags: ["rust", "computer-science", "compiler"]
description: "Improving Rust Build Times With Mold, The Magical Linker"
---

# Work In Progress

## Introduction

[Rust](https://www.rust-lang.org) is an incredible language. It's quite obvious when it was, as at 2022 was the most loved programming language for seven years,
according to a [survey](https://survey.stackoverflow.co/2022/#section-most-loved-dreaded-and-wanted-programming-scripting-and-markup-languages) made by [Stack Overflow](https://stackoverflow.com).

Guaranteeing memory-safety and thread-safety without even having a runtime or garbage collector.
Rust again provides us with a very smart compiler, top-notch tooling whilst being blazingly fast and highly memory-efficient.


Despite all these perks, build times in Rust are really nothing to write home about.
There are many reasons for this but one of the major ones has to do with the linker it uses by default.

Rust during the link stage invokes `cc`, the unix interface for the c compiler, usually set to GNU `gcc`, to link stuff which in turn invokes the GNU `ld` linker.
This linker has been around for more than two decades and is gradually showing its age, being orders of magnitude slower than current alternatives.

In this article we will explore how to speed up Rust build times significantly by replacing the default linker with a more modern, faster alternative, [Mold](https://www.github.com/rui314/mold).

## What is a linker

A linker is a software that basically takes individual compiled files and puts them together into one executable.
The build phase of a program written in a compiled language involve two __major__ steps;

* Each file is compiled separately into individual object files
* The linker combines these files together to form one executable or a shared library.

## What is Mold
__Mold__, from its official docs, "mold is a faster drop-in replacement for existing Unix linkers".
This means Mold has roughly the same interface as other Unix linkers allowing us to swap them without having any complications.
This is what makes it possible for us to use with Rust even though its not officially supported.

## Installing Mold

As at now, __Mold__ officially supports only Linux-based systems. You can either obtain prebuilt binaries or compile Mold from its source yourself.
If you want to go the prebuilt binary route, try using your package manager to install mold, for example if you are on Ubuntu you would do;
```bash
# Ubuntu
sudo apt-get install mold
```

If you could not get mold from your operating systems package manager, congratulations, you are only left with one option, building from source.

__Building From Source__

__Requirements__
1. C++ 20 Compiler
2. GCC >= 10.2 or Clang >= 12.0.0
3. libstdc++ >= 10 or libc++ >= 7

__Procedure__
1. Move into any directory you want to build __Mold__ in.
2. Run the following commands in your shell.
```bash
	git clone https://github.com/rui314/mold.git
	mkdir mold/build
	cd mold/build
	git checkout v1.10.1
	../install-build-deps.sh
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ ..
	cmake --build . -j $(nproc)
	sudo cmake --install .
```
When the process is done you should have a __Mold__ installation. Add it to your PATH variable if its not already on it.

## Using Mold

Now to use __Mold__, first create a rust project with any name of your choice and move into the project directory.
```bash
cargo new using_mold
cd using_mold
```

Create a new file, `.config/cargo.toml` in the project root directory. You may need to create the folder first.

Add this to the file you just created
```toml
[target.x86_64-unknown-linux-gnu] 
linker = "clang" 
rustflags = ["-C", "link-arg=-fuse-ld=/usr/bin/mold"]
```
Now you can write your __Rust__ code just as you did before without changing anything because __Mold__ as mentioned earlier is a drop-in replacement.

You could also place this same code in your `~/.cargo/config.toml` file if you would want to use __Mold__ as your default linker for every new project you start.

Note: if you get errors with the above step try replacing the `/usr/bin/mold` with the location of the __Mold__ binary you built earlier.

## Benchmarking Mold

At this point, I would like to test __Mold__ against __GNU ld__ with a simple program.
