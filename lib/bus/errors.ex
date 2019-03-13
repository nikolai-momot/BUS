defmodule Bus.NoUserError do
  defexception plug_status: 404,
               message: "no tournament found",
               conn: nil,
               router: nil
end