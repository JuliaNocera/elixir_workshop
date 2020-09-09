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
```

You should see a runtime error assuming you have not changed the implementation
of the `HttpResponseParser.parse/1` function.

```sh
** (RuntimeError) Not yet implemented
    (elixir_workshop 0.1.0) lib/http_response_parser.ex:10: HttpResponseParser.parse/1
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
