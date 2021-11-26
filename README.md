# pg-dump-repro-hb

Re-implementation of https://github.com/finestructure/vapor-lockup-repro.

Does _not_ reproduce the error, but crashes the server.

Steps to reproduce:

- git checkout rester  # this is the branch with the "rester" variant
- make db-up
- make run
- in another terminal: `make post`
- observe crash:
```
2021-11-26T11:02:30+0100 info HummingBird : HummingBird started successfully
Swift/ContiguousArrayBuffer.swift:580: Fatal error: Index out of range
make: *** [run] Trace/BPT trap: 5
```
