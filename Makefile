SHELL=/bin/sh
PREFIX?=/usr/local
SRC=$(wildcard *.sh)

install:
	for file in $(SRC); do install $$file $(PREFIX)/bin/$${file%.sh}; done

uninstall:
	for file in $(SRC); do rm -f $(PREFIX)/bin/$${file%.sh}; done


.PHONY: install uninstall
