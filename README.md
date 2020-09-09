# Elixir workshop

## Setup

Ensure you have Elixir and Erlang installed. I recommend using
[asdf](https://asdf-vm.com) to manage multiple Elixir/Erlang versions. To setup
`asdf`, follow the setup instructions [on the documentation](https://asdf-vm.com/#/core-manage-asdf-vm?id=install)

Make sure you install the `elixir` and `erlang` plugins for `asdf`:

```sh
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
```

Once you have `asdf` installed and ready to go, setup the project with the
following:

1. Fork the repo

2. Clone the repo

```sh
git clone git@github.com:<your-handle>/elixir_workshop.git
```

3. Change your directory to the workshop

```sh
cd elixir_workshop
```

4. Install Elixir and Erlang

```sh
asdf install
```

`asdf install` will use the `.tool-versions` file in this repo to install a
version of Elixir compatible with this project. Note this may take some time. Go
get yourself some coffee while erlang is compiling ☕️.

## Running tests

```sh
mix test
```
