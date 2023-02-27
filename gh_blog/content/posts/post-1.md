---
title: "A Deeper Dive Into Python - zip()"
date: 2023-02-26T00:52:03Z
tags: ["python", "deeper-dive-python", "zip"]
description: "Deeper Dive: Python - zip() function"
---

# Table Of Contents

- [Introduction](#introduction)
- [Declaration](#declaration)
- [Basics](#basics)
- [Details](#details)
- [Conclusion](#conclusion)
- [Resources](#resources)

## Introduction

The zip() function in Python takes an input of two or more of the basic collections in Python; the *list*, *set*, *tuple* and *dict*.
It returns an iterator (sequence) of tuples, where the first tuple contains the first elements of all the inputs, the second contains the second elements and so on.

We'll see how to use the Python zip() function in this article.

## Declaration

Syntax for the zip() function is as follows:

From The Docs: zip(*iterables, strict=False)

Pseudocode: zip(*iterables, strict=False) -> Iterator(*Tuple)

## Basics

```python
names = ["Alice", "Bob", "Sandra", "Theo"]
ages = [13, 14, 30, 31]

result = zip(names, ages)

print(result)
# <zip object at 0x7604ff7c82ad
```

We created two lists; `names` and `ages`.

We then called the zip() function with _names_ and _ages_ as arguments and stored the result in a variable named as such. 

From what we have established, the output should look like this;
`[("Alice", 13), ("Bob", 14), ("Sandra, 30"), ("Theo", 31)]`,
since the zip() function puts **each** first member into one list, the second member into another list.
Running this code gives another result though; `result` looks something like `<zip object at 0x7604ff7c82ad`.
It's a *memory address*, and is what Python returns when the zip function is invoked in this manner.
This memory address actually points to the iterator containing the tuples. An iterator is actually not a concrete structure like *list* or *set* and as a result does not show the data it contains.
We can easily obtain the zipped data by wrapping the iterator in a concrete object.

```python
names = ["Alice", "Bob", "Sandra", "Theo"]
ages = [13, 14, 30, 31]

result = list(zip(names, ages))

print(result)
# [("Alice", 13), ("Bob", 14), ("Sandra, 30"), ("Theo", 31)]
```

The code above now displays the expected `result` since the zip iterator has been converted to a list.
You can have just as easily wrapped it in a tuple or set.


The zip() function is also useful when you want to loop through more than one sequence at a time. Python allows you to loop through iterators so you do not need to wrap it in a list or tuple.

```python
numbers = [1, 2, 3]
doubles = [2, 4, 6]

# Without zip() function
for number in numbers:
	for double in doubles:
		print("Double of " + number + " is " + double)

# With zip() function
for (number, double) in zip(numbers, doubles):
	print("Double of " + number + " is " + double)

# Double of 1 is 2
# Double of 2 is 4
# Double of 3 is 6
```

## Details

The zip() function is *lazy*. This simply means that when you call the zip() function, the elements will not be processed until the iterator is used, that is, it is wrapped in a concrete sequence type or it is iterated on by a for loop.

So far all the lists we have "zipped" together have been of equal lengths, so what happens when the iterables, that is list or set, do not have equivalent lengths. The Python documentation states three approaches to this issue.

1. The zip() ignores other iterables immediately the shortest is exhausted, limiting the length of the result to the smallest sequence.

```python
res = []
for el in zip([1, 2, 3], [4, 5, 6, 7]):
	res.append(el)

print(res)
# [(1, 4), (2, 5), (3, 6)]
```

2. Padding with a constant value (None) to make all iterables have equal length.

```python
import itertools

first = ["F", "S", "T", "F"]
second = [1, 2, 3]

res = itertools.zip_longest(first, second)
print(list(res))
# [("F", 1), ("S", 2), ("T", 3), ("F", None)]

```

3. Enabling *strict* mode to raise a ValueError when the lengths of iterables being "zipped" are not the same.

```python

res = list(zip(range(3), range(4, 10), strict=True))
print(res)

# ValueError: zip() argument 2 is longer than argument 1

```

The zip() function returns an empty iterator if called with no arguments and returns a 1-tuple iterator if its called with only one iterable.


## Conclusion

We discussed what the Python zip() function is and its purpose.
We saw how to "zip" two or more sets together and return the values. We again saw how to loop through "zipped" sets.
Again, we learnt the various ways zip() could be used even if our iterables do not have the same length.

## Resources

The official docs for the zip() function can be found [here](https://docs.python.org/3/library/functions.html#zip).

