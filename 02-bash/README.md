# bash

I avoided using awk and kept things to utilities available on virtually every
modern linux bash environment.

run with:
```bash
> ./soln.sh part1 <input.txt>
> ./soln.sh part2 <input.txt>
```

## comments

this was hell from beginning to end, and I write one-off bash scripts all the
time. bash syntax is a pile of symbols stacked precipitously on top of each
other, and if you forget one suddenly you've deleted a file you didn't want to
or started spewing garbage to stdout. in this case specifically, I spent about
half of my time programming just bashing my head against the wall attempting to
understand subshell semantics. huh, maybe that's why they call it bash.
