.PHONY: install build create new-migration migrate \
	serve debug clean distclean lint format check-formatted help
.DEFAULT_GOAL := help

-include .Makefile.defaults

# Default options
#
# These can be overridden in .Makefile.defaults
export BUS_BIN_PATH         ?= vendor/bin
export BUS_DB_HOST          ?= localhost
export BUS_DB_NAME          ?= bus
export BUS_DB_USER          ?= bus
export BUS_DB_PASS          ?=
export BUS_ELIXIR_VERSION   ?= v1.6.4
export BUS_ERLANG_VERSION   ?= OTP-20.3.4
export BUS_PORT             ?= 42000

export PATH := $(PWD)/$(BUS_BIN_PATH):${PATH}
MIX   := $(BUS_BIN_PATH)/mix
IEX   := $(BUS_BIN_PATH)/iex
REBAR := $(BUS_BIN_PATH)/rebar

NODE ?= bus

install: $(MIX)
	@$(MIX) local.hex --force
	@$(MIX) local.rebar --force
	@$(MIX) deps.get

build: $(MIX) $(REBAR)
	@$(MIX) compile

createdb: build $(MIX)
	@$(MIX) ecto.create

new-migration: build $(MIX)
	@$(MIX) ecto.gen.migration new_migration

migrate: build $(MIX)
	@$(IEX) -S mix run -e "Bus.Utilities.Tasks.migrate"

serve: build $(MIX)
	@$(MIX) phx.server

debug: build $(MIX)
	@$(IEX) --sname ${NODE} -S mix phx.server

clean: $(MIX)
	@$(MIX) clean
	@([ ! -d rel/bus ] || rm -rf rel/bus)
	@([ ! -d doc ] || rm -rf doc)

distclean:
	@([ ! -d _build ] || rm -rf _build/*)
	@([ ! -d deps ] || rm -rf deps/*)
	@([ ! -d rel/bus ] || rm -rf rel/bus)
	@([ ! -d vendor ] || rm -rf vendor)

format: $(MIX) $(REBAR)
	@$(MIX) format --check-equivalent

check-formatted: $(MIX) $(REBAR)
	@$(MIX) format --check-formatted || \
		echo -e "\033[0;33m[WARN] Some files need to be formatted with \"make format\"\033[0m"

lint: $(MIX) $(REBAR)
	@$(MIX) credo --strict

vendor/build/otp:
	git clone --depth 1 --branch $(BUS_ERLANG_VERSION) \
		https://github.com/erlang/otp.git vendor/build/otp

vendor/build/elixir:
	git clone --depth 1 --branch $(BUS_ELIXIR_VERSION) \
		https://github.com/elixir-lang/elixir.git vendor/build/elixir

vendor/bin/erlc: vendor/build/otp
	cd vendor/build/otp && ./otp_build autoconf
	cd vendor/build/otp && ./configure \
		--prefix="$(PWD)/vendor" \
		--enable-builtin-zlib \
		--without-javac
	$(MAKE) -C vendor/build/otp -j4
	$(MAKE) -C vendor/build/otp install

vendor/bin/iex: vendor/bin/mix
vendor/bin/mix: vendor/bin/erlc vendor/build/elixir
	$(MAKE) -C vendor/build/elixir
	$(MAKE) -C vendor/build/elixir PREFIX="$(PWD)/vendor" install

# Needed by exometer
vendor/bin/rebar: vendor/build/elixir
	@cp vendor/build/elixir/rebar $@

help:
	@echo "Usage: make [target ...]"
	@echo
	@echo "Available commands:"
	@echo "  install          Install BUS dependencies"
	@echo "  build            Compile application code"
	@echo "  createdb         Create a database"
	@echo "  new-migration    Create a new migration template"
	@echo "  migrate          Run all available migrations on the database"
	@echo "  serve            Run the BUS server"
	@echo "  debug            Run the BUS server in IEx (REPL)"
	@echo "  clean            Remove generated files"
	@echo "  format           Format the files according to the formmat specified"
	@echo "  check-formatted  Check if all the files are formatted"
	@echo "  lint             Run static analysis on the code"
	@echo
	@echo "Both 'make serve' and 'make debug' support automatic code"
	@echo "reloading. On the next request after a source file is changed,"
	@echo "the module will be recompiled and loaded before the request is"
	@echo "handled."
	@echo
	@echo "For even more actions, run:"
	@echo "  ./mix help"
