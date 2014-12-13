retryer
=======

Available through [hackage](http://hackage.haskell.org/package/retryer).

Installing:

Have a working [haskell](https://www.haskell.org/platform/) install, and then

```bash
cabal install retryer
```

or

```bash
git clone https://github.com/dgonyeo/retryer.git
cd retryer
cabal install -j
```

Using:

```
Usage: retryer (-t|--tries <int>) (-d|--delay <double>) -- Command

Available options:
  -h,--help                Show this help text
  -t,--tries <int>         Number of times to retry the command. <= 0 disables.
  -d,--delay <double>      Seconds to wait before retrying the command. <= 0
                           disables.
```

So for example:

```bash
retryer -t 10 -d 5 -- ssh -p 222 user@example.com
```
