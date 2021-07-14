# SHA 256 into INT
|              |                                                            |
| ------------ | ---------------------------------------------------------- |
| name         | sha256-string-to-int         |
| version      | v0.0.1                                                     |
| docker image | [weevenetwork/sha256-string-to-int](https://linktodockerhub/) |
| tags         | Python, Flask, Docker, Weeve                               |
| authors      | Marcus Jones |


# Notes

This module strictly enforces the input data to be exactly of the form;

`{'random hash': '<sha 256 hash>'}`

Where `<sha 256 hash>` is a SHA 256 hash represented by a hex string such as;

`f36940fb3203f6e1b232f84eb3f796049c9cf1761a9297845e5f2453eb036f01`

`7080736e138ff40d7809467bf330be8f66e2a04deb0876c50ea04945dc13327c`

The module will return the integer representation of this byte string in the following form;

`{'256 byte integer':'<int>'}`