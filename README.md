# elixir-playground
Test application containing Elixir backend and simple JS frontend

## Next steps
- Compile my first application, break it up into multiple modules
    - c() function in `iex` is really handy. Can easily recompile code.
    - This takes a lot of getting used to. Multiple clauses of a single function and pattern matching vs assingment in particular
        are frying my brain at this point. Really fun though.
    - Note: each module needs to be compiled independent as far as I can tell if you're using iex.
    - [https://github.com/AgilionApps/remix](https://github.com/AgilionApps/remix) looks pretty solid; haven't tried it yet.
    - Importing modules is ultra easy. Just `require <module-name>` and make sure it's compiled in to the current environment.
    - I intentionally haven't messed much with build systems yet. Looks like `mix` is the way to do it but there seem to be a
        few new tools that I'm not familiar with there so I'm going to leave it on ice for now.
- Try out message passing across processes
    - Helpful article [here](https://howistart.org/posts/elixir/1) and docs [here](http://elixir-lang.org/docs/stable/elixir/Agent.html#get/3)
    - Actually fairly straightforward, at least in the Agent case. Agents are used for maintaining state.
    - Things like inventory, properties of users, etc should be fairly to extend w/ the User module I built here.
- Get messages and add messages to state-tracking process
    - Agents! Pretty slick. 
- Appreciate how awesome that is
    - It's very awesome. At this point I'm actually feeling my brain start to change.
- Create basic Phoenix module to listen for requests (GET and POST)
- Add messages and retrieve messages based on Phoenix requests