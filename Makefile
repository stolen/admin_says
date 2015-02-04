PROJECT = quoter
SHELL_OPTS = -s quoter

DEPS = cowboy erlydtl ibrowse
dep_cowboy = git https://github.com/ninenines/cowboy 1.0.0
dep_ibrowse = git https://github.com/cmullaparthi/ibrowse.git master

include erlang.mk
