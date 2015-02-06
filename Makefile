PROJECT = quoter
SHELL_OPTS = -s quoter

DEPS = cowboy erlydtl
dep_cowboy = git https://github.com/ninenines/cowboy 1.0.0

include erlang.mk
