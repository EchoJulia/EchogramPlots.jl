# EchogramPlots

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
echogram(Sv38, title="38kHz volume backscatter", range=r)
```

## Bitmap

Black and white echograms are also possible with `BitArray`s

```
echogram(rand(100,100) .> 0.5,color=:grays, leg=false)
```
