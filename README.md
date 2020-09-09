# ElixirWorkshop

## Setup

Ensure you have a Elixir and Erlang installed. If you would like to manage
multiple Elixir and Erlang versions, I recommend using [asdf](https://asdf-vm.com)

Once you have `asdf`, run the following

```sh
git clone git@github.com:jerelmiller/elixir_workshop.git
cd elixir_workshop
asdf install
```

`asdf install` will use the `.tool-versions` file to install a version of Elixir
compatible with this project.

## Running tests

```sh
mix test
```
