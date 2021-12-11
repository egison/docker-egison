# The Egison Programming Language

![Build Status](https://github.com/egison/docker-egison/workflows/build/badge.svg)

Egison is the **pattern-matching-oriented**, purely functional programming language.
We can directly represent pattern-matching against lists, multisets, sets, trees, graphs and any kind of data types.
This is the docker repository of the interpreter of Egison.

## Installation

We assume you are already familiar with Docker.

```sh
docker pull egison/egison:latest
```

## Case 1. Run Interpreter

We can call the Egison interpreter with the following command.

```shellsession
$ docker run -t -i egison/egison:latest
Egison Version 3.5.6 (C) 2011-2014 Satoshi Egi
http://www.egison.org
Welcome to Egison Interpreter!
>
Leaving Egison Interpreter.
```

## Case 2. Execute Egison Script

We can execute an Egison script with the following command.
We can execute an Egison script under the current directory.

```shellsession
$ cat > hello.egi
(define $main
  (lambda [$args]
    (print "Hello, world!")))
$ docker run -t -i -v $(pwd):/docker:ro egison/egison:latest hello.egi
Hello, world!
```

## Setting

We can set an alias as follow.

```shellsession
$ alias egison-docker='docker run -t -i -v $(pwd):/docker:ro egison/egison:latest'
$ egison-docker
Egison Version 3.5.6 (C) 2011-2014 Satoshi Egi
http://www.egison.org
Welcome to Egison Interpreter!
>
Leaving Egison Interpreter.
$ egison-docker hello.egi
Hello, world!
```

## Links

- [Egison website](http://www.egison.org)
- [Egison on GitHub](https://github.com/egison/egison)
