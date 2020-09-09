# ElixirWorkshop

## Setup

Ensure you have Elixir and Erlang installed. I recommend using
[asdf](https://asdf-vm.com) to manage multiple Elixir/Erlang versions. To setup
`asdf`, follow the setup instructions [on the documentation](https://asdf-vm.com/#/core-manage-asdf-vm?id=install)

Once you have `asdf`, setup the project with the following:

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
