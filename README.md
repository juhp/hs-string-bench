# hs-string-bench

This compares ``needle `isInfixOf` hay`` for
Haskell Data.List, Data.Text, Data.ByteString, etc.

This timings are made with tasty-bench.
There are two files: toolbox.spec (an rpm spec file)
and lorem-ipsum (familiar typographic Latin text).

## Matching words

The needle is the first word in a line.
```
  "%gometa" in data/toolbox.spec
    Data.String:           OK (1.45s)
       21 μs ± 1.3 μs
    Data.Text:             OK (0.18s)
       43 μs ± 3.2 μs
    Data.Text.Lazy:        OK (0.55s)
       16 μs ± 809 ns
    Data.ByteString:       OK (0.71s)
       10 μs ± 542 ns
    Data.ByteString.Char8: OK (0.37s)
       11 μs ± 1.0 μs
```
In the middle of a long line:
```
  "dolorum" in data/lorem-ipsum
    Data.String:           OK (0.97s)
       58 μs ± 822 ns
    Data.Text:             OK (0.26s)
       31 μs ± 2.0 μs
    Data.Text.Lazy:        OK (0.21s)
       26 μs ± 1.5 μs
    Data.ByteString:       OK (0.44s)
       13 μs ± 927 ns
    Data.ByteString.Char8: OK (0.22s)
       13 μs ± 795 ns
```

## No matches: reading over whole file
```
  "dolorum" in data/toolbox.spec
    Data.String:           OK (0.19s)
      179 μs ±  18 μs
    Data.Text:             OK (0.28s)
       67 μs ± 3.1 μs
    Data.Text.Lazy:        OK (0.25s)
       59 μs ± 3.0 μs
    Data.ByteString:       OK (0.32s)
       19 μs ± 1.3 μs
    Data.ByteString.Char8: OK (0.15s)
       18 μs ± 1.8 μs

  "%gometa" in data/lorem-ipsum
    Data.String:           OK (0.15s)
       76 μs ± 6.5 μs
    Data.Text:             OK (0.29s)
       36 μs ± 2.3 μs
    Data.Text.Lazy:        OK (0.12s)
       30 μs ± 2.9 μs
    Data.ByteString:       OK (0.95s)
       14 μs ± 1.2 μs
    Data.ByteString.Char8: OK (1.88s)
       14 μs ± 213 ns
```

It seems longer lines/text hits String pretty hard


## Notes
It would be nice to add some simple Streaming examples too:
cf [streaming-benchmarks](https://github.com/composewell/streaming-benchmarks).
