HC ?= ghc-8.6.5

build :
	cabal new-build -w $(HC) --enable-tests

self-test :
	cabal new-run -w $(HC) haskell-ci -- --config=cabal.haskell-ci haskell-ci.cabal

ghcid :
	ghcid -c 'cabal new-repl -w $(HC)'

install:
	cabal new-install haskell-ci:exe:haskell-ci --overwrite-policy=always

install-dev : build
	cp $$(cabal-plan list-bin haskell-ci) $(HOME)/.cabal/bin/haskell-ci

test : build
	cabal new-run -w $(HC) --enable-tests golden

accept : build
	cabal new-run -w $(HC) --enable-tests golden -- --accept

doctest :
	doctest --fast -XDeriveFunctor -XDeriveFoldable -XDeriveTraversable -XDeriveGeneric src
