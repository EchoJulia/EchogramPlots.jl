# EchogramPlots


[![Build Status](https://travis-ci.org/EchoJulia/EchogramPlots.jl.svg?branch=master)](https://travis-ci.org/EchoJulia/EchogramPlots.jl)

[![Coverage Status](https://coveralls.io/repos/EchoJulia/EchogramPlots.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/EchoJulia/EchogramPlots.jl?branch=master)

[![codecov.io](http://codecov.io/github/EchoJulia/EchogramPlots.jl/coverage.svg?branch=master)](http://codecov.io/github/EchoJulia/EchogramPlots.jl?branch=master)

## Introduction

Simple echogram displays of arbitrary matrices in Julia.

Works in IJulia or any Julia development environment.

Supports many of the Plots.jl backends.

## Simple example

```
using EchogramPlots
echogram(rand(100,100))
```

## EK60 example

A useful companion to the SimradEK60.jl package.

```
using EchogramPlots
using SimradRaw
using SimradEK60
ps =collect(pings(EK60_SAMPLE));
ps38 = [p for p in ps if p.frequency == 38000];
Sv38 = Sv(ps38);
r = R(ps38);
echogram(Sv38, title="38kHz volume backscatter", range=maximum(r))
```

## Bitmap

Black and white echograms are also possible with `BitArray`s

```
echogram(rand(100,100) .> 0.5,color=:grays, leg=false)
```
