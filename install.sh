#!/bin/sh

tt lib/xpointergrammar.treetop
rake clobber_package
rake gem
gem install pkg/*.gem
