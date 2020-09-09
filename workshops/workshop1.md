# Workshop 1

The purpose of this workshop is to get your feet wet with Elixir. Today we will
be learning how to use some basics in Elixir, use `mix` to install dependencies,
and how to use `mix` to run tests.

## `IEx`

[IEx](https://hexdocs.pm/iex/IEx.html) is an interactive shell used to run
Elixir code. We will be using it today to demonstrate some of Elixir's basics
and get a feel for how to use it. Note that in a production application, it is
best to try and write tests to determine if your application functions as you
expect. That being said, `IEx` can be a really useful tool to play around with
the code in your application.

### Running `iex`

You can start up an interactive shell by running the `iex` command. This will
allow you to evaluate Elixir code using a REPL.

To demonstrate, open `iex` and type the following:

```elixir
iex> 1 + 1
2
```

You should see `2` printed below the prompt.

You can use `IEx` to evaluate much more complex expressions, such as the
pipeline operator:

```elixir
iex> "This is neat" |> String.downcase() |> String.replace(~r/\s+/, "-")
```

Running `iex` on its own is nice, but unfortunately it doesn't load your
project, which means you can't interact with it. You will need to pass an
additional flag if you would like to load the project.

### Using `iex` to load your project

To use `iex` to load your project, run the following in the root of this
project:

```sh
iex -S mix
```

This will allow you to interact with this project. Try running the following:

```elixir
iex> HttpResponseParser.parse(%{})
:not_yet_implemented
```

You should see a runtime error assuming you have not changed the implementation
of the `HttpResponseParser.parse/1` function.

```sh

```

### Getting documentation for a module

Elixir has first class support for documentation within code. To access the
documentation for a module, use the `h/1` function inside `iex`:

```elixir
iex> h String
```

This should print the module's documentation for the `String` module.

### Getting documentation for a function

Not only can you access a module's documentation, but you can also use the `h/1`
function to get documentation for a function within a module. To access the
documentation for a function, run the following:

```elixir
iex> h String.split/2
```

You should see the documentation for the `String.split/2` function printed to
the screen.

### Recompiling

Since Elixir needs to be compiled before it can be evalated, this means that
changes to your application are not reflected in `iex`. If you make changes to
your app code, you can use the `recompile/0` function to recompile your
application. This will recompile your entire app.

To try this out, fire up `iex` and run the following:

```elixir
iex> HttpResponseParser.parse(%{})
:not_yet_implemented
```

Now make a change to the implementation of `HttpResponseParser.parse/1`, for
example, changing the `:not_yet_implemented` atom to `:todo`

```elixir
iex> recompile()
Compiling 1 file (.ex)
:ok
iex> HttpResponseParser.parse(%{})
:todo
```

## `Mix`

Per the [documentation](https://hexdocs.pm/mix):

> Mix is a build tool that provides tasks for creating, compiling, and testing
> Elixir projects, managing its dependencies, and more.

We will be using `mix` today to install dependencies and run our tests. `mix` is
akin to Node's `npm` tool.

### `mix.exs`

The `mix.exs` file defins our Elixir project. Here you can see information about
our app, such as its version, or the compatible Elixir versions. This is the
file that you will update when you need to install dependencies for your
project.

To learn more about configuring the project, read the [`mix`
documentation](https://hexdocs.pm/mix).

### Installing dependencies

Our project currently has no dependencies, as evidenced by the empty list in the
`deps/0` function inside our `mix.exs` file.

```elixir
defp deps do
  []
end
```

You will see a comment inside of there with instructions to install the
[`Jason`](https://hexdocs.pm/jason) library. `Jason` is a JSON parser and
generator written using pure Elixir. We will be using this for our workshop
today.

To install `Jason`, uncomment the line that specifies the dependency. Feel free
to remove the other comments. Your `deps/0` function should now look like the
following:

```elixir
defp deps do
  [
    {:jason, "~> 1.2"}
  ]
end
```

To install the dependencies, run the following:

```sh
mix deps.get
```

After you run this, you should see a `mix.lock` file created in the repo.

**NOTE:** If you have not yet installed hex (Elixir's package manager), you will
be prompted to do so. You'll see a message like the following:

```sh
Could not find Hex, which is needed to build dependency :jason
Shall I install Hex? (if running non-interactively, use "mix local.hex --force") [Yn]
```

Type `Y` to install `hex`. This should only happen once.

### Running tests

To run tests, use the following command:

```sh
mix test
```

This will run all tests in your application under the `test` directory named
with the `_test.exs` suffix.

You can run a single test file by passing the file path to `mix test`:

```sh
mix test test/http_response_parser_test.exs
```

You can also run a single test in a file by appending the line number:

```sh
mix test test/http_response_parser_test.exs:11
```

**NOTE**:

For our workshop today, you will notice that some of the tests are skipped. You
will see the `@tag :pending` attribute definition placed above some of the
tests. By default these are skipped. This will allow you to work at your own
pace and get to a green test before moving onto more complicated functionality.

Simply remove the `@tag :pending` statement to run that test as part of `mix test`.

### `mix help`

If you would like to see all of the available tasks that can be run in a `mix`
project, use the `mix help` command. To get more detailed documentation on a
task, run `mix help` with the name of the task. For example, to get more
detailed documentation on the `mix test` command, run `mix help test`.

## Today's task

My hope is that you have read, or partially read the 1st and 2nd chapter of the
Elixir in Action book. We will be using some of the concepts from those chapters
to implement our task.

Our task today is to implement an HTTP response parser. We will be using test
driven development to drive the implementation of our module.

The project has a single module named `HttpResponseParser`, defined at
`lib/http_response_parser.ex`. Inside of this module, you will see a single
function: `HttpResponseParser.parse/1`. Our goal is to implement this function
given a variety of HTTP responses from the Pokeapi. Our parser will allow us to
take a response and extract the body of the response, optionally parsing it into
JSON. We will also need to handle errors. Our parser will allow us to easily
pattern match on the result and extract the contents of the body.

**Additional info for the nerds**:

Our tests today are using a simplified response from the [Poke
API](https://pokeapi.co/). The structure I used was created from a library
called [`HTTPoision`](http://hexdocs.pm/httpoison), which is an HTTP client for
Elixir. While the data is simplified, you will find the structure to look almost
identical to the `%HTTPoision.Response{}` struct.

### Elixir concepts

#### Maps

Maps are key/value pairs, akin to a JavaScript object.

```elixir
%{make: "Subaru", model: "Ascent"}
```

Keys can be atoms, or they can be strings:

```elixir
%{"make" => "Subaru", "model" => "Ascent"}
```

Note that when using string keys, you must use the hash rocket syntax to define
the relationship. Keys that are atoms can also be specified using the hash
rocket syntax

```elixir
%{:make => "Subaru", :model => "Ascent"}
```

The first variant is a shorthand for keys that are atoms.
