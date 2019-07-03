# Elixir Project Euler

Elixir scaffolding for [https://projecteuler.net/](https://projecteuler.net/)

This repo is a simple Mix project with boilerplate generated for each problem.

It comes with a mix task to check your solutions against the preconfigured correct answers and a mix task to benchmark your various solution implementations against one another (using the excellent [benchee](https://github.com/bencheeorg/benchee) library).

## Usage

* Clone this repo: `git clone git@github.com:ryan-senn/elixir-project-euler.git`.
* Navigate to the project with `cd elixir-project-euler`.
* Run `mix deps.get` to install the dependencies (dependency really, just benchee)
* Run `mix problems.generate` to generate the boilerplate for each problem.
* Open `./lib/problem_1.ex` in your favourite code editor.
* Follow the commented link at the top (eg. https://projecteuler.net/problem=1) to read up on the problem and implement `solution_1`
* Test your solution with `mix problem.test 1`, where `1` is the problem number. There is a `mix t 1` shorthand that does the same (t for test).
* *Optional* Comment out and implement `solution_2`. Running `mix problem.test 1` will detect the new solution and verify both.
* Run `mix problem.benchmark 1` to see which implementation is more efficient. There is a `mix bm 1` shorthand that does the same (bm for benchmark).
* *Optional* Implement as many solutions as you want. Make sure to name your solutions `solution_{solution_number}` with no params and repeat the testing and benchmarking steps above.
* Move to `./lib/problem_2.ex` and repeat the steps above using `mix problem.test 2` etc.

## Changing the boilerplate for problems

If you don't like the generated boilerplate for each problem, you can change what is generated by editing `./lib/mix/tasks/generate_problems.ex` and updating the `boilerplate` function to your liking.

Once done, run `mix problems.generate` again. It will fail if the destination file already exists, so either delete the files that you want to overwrite manually or use the `--force` flag. Note that the `--force` flag will erase all your existing solutions so be careful!