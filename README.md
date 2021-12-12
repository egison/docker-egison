# The Egison Programming Language

Egison is the **pattern-matching-oriented**, purely functional programming language.
We can directly represent pattern-matching against lists, multisets, sets, trees, graphs and any kind of data types.
This is the docker repository of the interpreter of Egison.

## Installation

We assume you are already familiar with Docker.

```sh
docker pull egison/egison
```

## Case 1. Run Interpreter

We can call the Egison interpreter with the following command.

```shellsession
$ docker run -t -i egison/egison
Egison Version 4.1.2
https://www.egison.org
Welcome to Egison Interpreter!
>
Leaving Egison Interpreter.
```

## Case 2. Execute Egison Script

We can execute an Egison script with the following command evn under local current directory.

```shellsession
$ cat > hello.egi
def main args := do
  print "Hello, world!"
$ docker run -it -v $(pwd):/docker:ro egison/egison:latest hello.egi
Hello, world!
```

## Setting

We can set an alias as follow.

```shellsession
$ alias egison-docker='docker run -it -v $(pwd):/docker:ro egison/egison'
$ egison-docker
Egison Version 4.1.2
https://www.egison.org
Welcome to Egison Interpreter!
>
Leaving Egison Interpreter.
$ egison-docker hello.egi
Hello, world!
```

## Links

- [Egison website](http://www.egison.org)
- [Egison on GitHub](https://github.com/egison/egison)
