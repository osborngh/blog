---
title: "Speeding Up Rust With Mold"
date: 2023-03-05T00:52:41Z
author: "Da Vinci"
tags: ["computer-science", "rust", "compilers"]
description: "Improving Rust Build Times With Mold, The Magical Linker."
---

# Work In Progress

## Introduction

[Rust](https://www.rust-lang.org) is an incredible language. It's quite obvious when it was, as at 2022 was the most loved programming language for seven years,
according to a [survey](https://survey.stackoverflow.co/2022/#section-most-loved-dreaded-and-wanted-programming-scripting-and-markup-languages) made by [Stack Overflow](https://stackoverflow.com).
Guaranteeing memory-safety and thread-safety without even having a runtime or garbage collector.
Rust again provides us with a very smart compiler, top-notch tooling whilst being blazingly fast and highly memory-efficient.


Despite all these perks, everyone who uses Rust especially in projects with lots of dependencies can attest to the fact of very long build times in Rust.
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
From its official docs, "mold is a faster drop-in replacement for existing Unix linkers".
This means Mold has roughly the same interface as other Unix linkers allowing us to swap them without having any complications.
This is what makes it possible for us to use with Rust even though its not officially supported.

The reason why __Mold__ is faster than existing Unix linkers is because of the algorithms and techniques it employs.
Another reason is because of parallelization of the linker. It uses all available cores to get stuff done quickly. 

Existing Unix linkers, usually being decades older were not designed take full advantage of modern techniques and algorithms.

## Installing Mold

As at now, __Mold__ officially supports only Linux-based systems. You can either obtain prebuilt binaries or compile Mold from its source yourself.
If you want to go the prebuilt binary route, try using your package manager to install mold, for example if you are on Ubuntu you would do;
```bash
# Ubuntu
sudo apt-get install mold
```

If you could not install __Mold__ from your package manager, congratulations, you are only left with one option, building from source.

## Building From Source

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

__With Cargo__

Now to use __Mold__ with cargo, Rust's multipurpose tool, first create a rust project or open an existing one in which you would want to use __Mold__ as the project linker.

```bash
cargo new using_mold
cd using_mold
```

Create a new file, `.config/cargo.toml` in the project root directory. You may need to create the folder first.

```bash
mkdir .config
touch .config/cargo.toml
```

Add this linker configuration to the `.config/cargo.toml` file you just created.
```toml
[target.x86_64-unknown-linux-gnu] 
linker = "clang" 
rustflags = ["-C", "link-arg=-fuse-ld=/usr/bin/mold"]
```
Now you can write your __Rust__ code just as you did before without changing anything because __Mold__, as mentioned earlier is a drop-in replacement.

You could also place this toml code in your `~/.cargo/config.toml` file, if you would want to switch to __Mold__ as your default linker for every new project you start.

__Without Cargo__

If for some reason you decide not to use cargo for your project, you can still use __Mold__ to link your project. Whatever your project structure is, start your compilation process with the `RUSTFLAGS` environment variable set like so;
```bash
# main.rs is assumed to have the main function.
# lib.rs is assumed to have library code.

# Executable
RUSTFLAGS=-Clinker=/usr/bin/mold rustc -o cookie main.rs

# Library
RUSTFLAGS=-Clinker=/usr/bin/mold rustc --crate-type=lib lib.rs
```

Note: if you got errors with the steps above, try replacing the `/usr/bin/mold` with the location of the __Mold__ binary you built earlier.

## Benchmarking Mold

The __Mold__ homepage has benchmarks which clearly depict how __Mold__ outperforms its competitors by a large margin. Let's see how it works for our _usually_ relatively smaller projects.

We'll be comparing the link speeds of  __Mold__, __GNU ld__ and another well known linker, __Clang lld__.

To increase the workload of the linker, we'll be using an external dependency. I decided to go with the [Bevy](www.bevyengine.org) library.
It's quite popular in the Rust community and is relatively easy to get started with.

We are not going to be writing any code since adding external dependencies contributes to the linker's workload.

__Results__

The test machine is a relatively low powered 64-bit Ubuntu laptop with 4gb of RAM with 4 processor cores.

1. __Mold__
```bash
cargo build

# 
```

2. __GNU ld__
```bash
cargo build

# 
```

3. __Clang lld__
```bash
cargo build

# 
```


## Conclusion

The speed __Mold__ offers increases with increasing dependencies so is observed in larger projects. Using a faster linker with Rust can improve the software development cycle.
