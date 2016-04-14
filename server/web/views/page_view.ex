defmodule Chatserver.PageView do
  use Chatserver.Web, :view
  
  def title do
    "Sweet app"
  end
  
  # This function (and every function on this view) is available to be used in the
  # templates. This function reads from the UserService using a hard-coded :user1
  # atom.
  #
  # I think you could start creating multiple User agents with unique ID's but I'm not
  # sure how to bind one to a connection (or whatever it would take to have a persistent
  # representation of the user).
  def playername() do
    # Get user information using the :users registered name
    {:name, name} = UserService.Worker.get(:user1, :name)
    # Whatever value you return is what gets plugged in to the template
    name
  end
end
