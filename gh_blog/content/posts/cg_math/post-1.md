---
title: "Computer Graphics Maths: Introduction"
date: 2023-03-11T12:41:25Z
author: "Da Vinci"
tags: ["computer-graphics", "math", "linear-algebra", "programming", "python"]
description: "Introduction to a series of articles treating fundamental Mathematics in Computer Graphics."
series: ["Maths For Computer Graphics"]
---

# Introduction

When I began learning Computer Graphics, it was all fun and games (pun intended) until I started to see "complicated" stuff like __Matrices__ and __Quaternions__ everywhere. At first I avoided the Mathematics altogether, and I got by, mainly using various Math libraries. But trying to advance in Computer Graphics as a field, I discovered that learning the fundamental Mathematics is quite inevitable. 

It was not easy trying to understand a graphics API and then being caught of guard with something which seemed so much more difficult to comprehend.
It is for this very reason that I want to provide a lean set of articles introducing the reader to an important subset of Mathematics in Computer Graphics.

This set of articles, although quite useful to everyone, is mainly aimed at youngsters, who want to explore Computer Graphics without having to deal with a great deal of complexity with the Mathematics involved.
It might also appeal to you if you're learning a graphics API like [OpenGL](www.opengl.org), [Vulkan](vulkan.org) or [DirectX](https://en.wikipedia.org/wiki/DirectX) and do not understand the basic math, although you should most likely be using a tested Math library for serious projects.

However there is a problem with trying to teach only the Mathematics For Computer Graphics, you must already understand the Computer Graphics beforehand. This limits the topics we can treat without this series turning into a full on Computer Graphics series. To counter this, I recommend you having a book which offers a fundamental treatment of computer graphics.

Also this series, we are also going to be implementing our own Math library, __Centauri__.

The source code is available on [github](https://www.github.com/osborngh). Each topic of the series has a dedicated branch which has only features implemented up to that point in it.

If you don't understand what 'branch' or even 'github' is, you should probably checkout the series of articles at [Atlassian](https://www.atlassian.com/git/tutorials). Just start with the beginner section on the site but avoid any `Bitbucket` stuff you see on the site for now.

# Topics Of The Series

We're going to be treating these particular topics in this order.

1. [Vectors](/post-2.md)
1. [Matrices](/post-3.md)
1. [Linear Transformations](/post-4.md)
1. [3D Rotation](/post-5.md)
1. [Miscellaneous](/post-6.md)

# Book Recommendations

The best book I have used for treating Maths related to Computer Graphics is [3D Math Primer for Graphics and Game Development](https://www.amazon.com/Math-Primer-Graphics-Game-Development/dp/1568817231).

For learning fundamental Computer Graphics, I recommend you start with [Fundamentals of Computer Graphics](https://www.amazon.com/Fundamentals-Computer-Graphics-Steve-Marschner/dp/1482229390). There are other arguably better books but they are usually orders of magnitude larger, and unless you have time (which high school/college student really does?) just stick with this.

If you are Math savvy and would want to go more in depth on the Mathematical Side of things, a good book (I'm still reading it) is [Linear Algebra And Its Applications](https://www.amazon.com/Linear-Algebra-Its-Applications-5th/dp/032198238X)

# Side Notes

Good Websites for Learning:

1. [OpenGL](https://www.learnopengl.com)
2. [Vulkan](https://vulkan-tutorial.org)
3. [DirectX](https://directxtutorial.com)

Disclaimer: I haven't really used DirectX, but the articles look pretty good.
