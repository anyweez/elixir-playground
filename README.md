# elixir-playground
Test application containing Elixir backend and simple JS frontend.

- Run `gulp` from inside of `client/web` to build the frontend, then open `index.html` from the `public/` folder.
- Run `mix phoenix.server` from inside of `server/` to build and run the backend.

## Next steps
- **Compile my first application, break it up into multiple modules**
    - c() function in `iex` is really handy. Can easily recompile code.
    - This takes a lot of getting used to. Multiple clauses of a single function and pattern matching vs assingment in particular
        are frying my brain at this point. Really fun though.
    - Note: each module needs to be compiled independent as far as I can tell if you're using iex.
    - [https://github.com/AgilionApps/remix](https://github.com/AgilionApps/remix) looks pretty solid; haven't tried it yet.
    - Importing modules is ultra easy. Just `require <module-name>` and make sure it's compiled in to the current environment.
    - I intentionally haven't messed much with build systems yet. Looks like `mix` is the way to do it but there seem to be a
        few new tools that I'm not familiar with there so I'm going to leave it on ice for now.
- **Try out message passing across processes**
    - Helpful article [here](https://howistart.org/posts/elixir/1) and docs [here](http://elixir-lang.org/docs/stable/elixir/Agent.html#get/3)
    - Actually fairly straightforward, at least in the Agent case. Agents are used for maintaining state.
    - Things like inventory, properties of users, etc should be fairly to extend w/ the User module I built here.
- **Get messages and add messages to state-tracking process**
    - Agents! Pretty slick. 
- **Appreciate how awesome that is**
    - It's very awesome. At this point I'm actually feeling my brain start to change.
    - I saved a lot of suffering by reading over the [quick Mix intro](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html). 
      `mix new` in particular is pretty sweet.
- **Create basic Phoenix module to listen for requests (GET and POST)**
    - This is where I gave in and autogenerated a project. Undoubtedly the right play, though I still have a LOT more learning to do.
    - Did a bit of basic work with GET requests, routers, etc. Did more on channels (websockets to browsers).
    - Phoenix splits along MVC lines, though connecting the dots took some time. Views and templates are actually pretty intuitive once you realize
      that *functions you define in the view are available in the templates*. Pretty clean and supposedly lightning fast.
    - Profanity-laced breakthrough of today: name registration. I couldn't figure out how to retrieve agents that I'd created in separate processes
      but it turns out you can provide a name instead of a reference to the actual pid and it looks it up automatically (!!!!!!). I'm using atoms as
      ID's, so its pretty straightforward to use hard-coded values. Also services (:users) should be safe to hard-code. This is insanely powerful.
    - I also wrote a really simple JS web client to test the server with. I used [this library](https://github.com/mspanc/phoenix_socket/blob/master/dist/socket.js) 
      and the comments in the code are really helpful. There's also a sample project in the `web/static/` directory that was autogenerated by Phoenix.
    - Channels have one of the better [help articles](http://www.phoenixframework.org/docs/channels) on the Phoenix website. In retrospect I think it
      would've been helpful to look at for GET and POST requests too though not all of the modules are used (many are the same or similar).
- **Add messages and retrieve messages based on Phoenix requests**
    - Kinda easy for a hello world version once you have the other stuff set up! Channels have `join`, `handle_in`, and `handle_out` functions that
      you can define for accepting new connections and forwarding messages between them.
    - Everything I'm currently doing is a broadcast but you should be able to use the `socket` provided as an input to route back to the sender if
      needed.
      
# Phoenix project important files / concepts
- `mix.exs` is the package.json of Elixir. Two most important responsibilities thus far: registering dependencies (`mix deps.get` to install) and 
  defining the entry point for the application (`application` function, see 'mod').
- Application files 'belong' in the `lib/` directory. There's also a `web/` directory and I don't have a clear distinction on why a lot of Elixir
  and Phoenix files are stored there except that they seem to be routers, models, views, etc instead of 'core' application files? Doesn't seem
  like a clear line.
- Creating a new Phoenix project will automatically create a new application to be your entry point (needs to `use Application`). I added a worker
  process to the supervisor that acts as a user service (agent that keeps track of state related to users, which spawns another process for each
  user). They've automatically got supervisors in there so we get all of the awesome fault tolerance benefits out of the box.
-  ...more to come...